public class AccountTrigger_handler {
    public static void AfterInsertAccount(List<Account>newlist){ 
        
        Pricebook2 pb = [select id, name, isStandard from Pricebook2 where isStandard = true And isActive = false];
        account lst = [select id, name from account where id =: newlist];
        
        Contact con = new Contact();
        con.lastName = lst.Name;
        con.AccountId = lst.id;
        insert con;
        
        Opportunity op = new Opportunity();
        op.Name = lst.Name;
        op.AccountId = lst.id;
        op.ContactId = con.id;
        op.StageName = 'Qualification';
        Op.CloseDate = system.today()+2;
        insert op;
        
        Product2 pd = new Product2();
        pd.Name = 'Cello Ball pen';
        pd.IsActive = true;
        pd.Description ='Its A Cello product';
        pd.ProductCode = 'CELLO-18990';
        insert pd;
        
        PricebookEntry pe =  new PricebookEntry();
        pe.IsActive = true;
        pe.Pricebook2Id = pb.Id;
        pe.Product2Id = pd.Id;
        pe.UseStandardPrice =false;
        pe.UnitPrice = 10;
        insert pe;
        
        OpportunityLineItem oli = new OpportunityLineItem();
        oli.Quantity =100;
        oli.UnitPrice =8;
        oli.Product2Id = pd.id;
        oli.PricebookEntryId = pe.id;
        oli.OpportunityId = op.id;
        insert oli;       
    }
    //----------------------Updating Account related opportunity stage-----------------------
    //SCENARIO-> On account updation acc related opportunity who have a time of more than 30 days,
    //			check their stage is not closed won make them closed lost.
    public static void afterUpdateAccount(List<Account>newlist){ 
        
        list<opportunity> olist = new list<opportunity>();
        for(Opportunity op : [select id, AccountId, name, stagename, createdDate from Opportunity
                              where createdDate <LAST_N_DAYS:30  AND stagename != 'Closed Won' AND AccountId =: newlist]){
                                  op.StageName = 'Closed Lost';
                                  olist.add(op);
                              }
        update olist;
    }
    //--------------------------------------------------------------------------------------//
    
    public static void sendNotification(list<Account> newlist){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        
        List<Messaging.Email> emailMsg =  new List<Messaging.Email>();
        
        for(Account a : newlist){
            if(a.Active__c == 'Yes' ){
                
                for(user u :[select id, FirstName, LastName, email from user where id =: a.OwnerId]){
                    messaging.SingleEmailMessage msg = new messaging.SingleEmailMessage();
                    string[] ToAddress = new string[]{u.Email};
                        msg.setToAddresses(ToAddress);
                    string emailSub = 'Congratulations...'+ u.FirstName;
                    msg.setSubject(emailSub);
                    string disname = 'Plus91Labs';
                    msg.setSenderDisplayName(disname);
                    string Contents = 'Hi, '+u.FirstName +',<br/><br/>'+ 'Your Account '+ a.Id+''+ a.Name +' is Activated successfully.';
                    msg.setHtmlBody(Contents);
                    emailMsg.add(msg);
                }
            }
        }
        messaging.sendEmail(emailMsg);
    }
    
    //before update 
    public static void updateType(map<id, account> newmap){
        for(Account a : newmap.values()){
            if(a.Status__c == 'Active'){
                a.Rating = 'Cold';
            }
        }
        list<contact> clist = new list<contact>();
        for(Contact c: [select id, name, AccountId, subject__c from contact where AccountId in : newmap.keySet()]){
            For(Account a: newmap.Values()){
                if(a.Rating == 'Cold'){
                    c.subject__c = 'Your Account Rating Changed to ' + a.Rating;
                    clist.add(c);
                }
            }
        }
        update clist;
        system.debug('List: ' + clist);
        
    }
    
    //after update
    
    public static void createUser(list<Account> newlist){
        list<User> ul = new list <User>();
        for(Account a : newlist){
            if(a.Active__c =='yes'){
                system.debug('account is active');
                Profile p = [select id, name from profile where name  = 'SFDC 1' limit 1 ];
                User u = new User();
                
                u.FirstName = a.Name;
                u.LastName = 'Method';
                u.Alias =u.FirstName.LEFT (1) +u.LastName.RIGHT (4) ;
                u.Email= 'akash@plus91labs.com';
                u.Username = 'abc5d@123.com.test';
                u.CommunityNickname = 'USER12456567890';
                u.ProfileID = p.Id;
                u.LocaleSidKey = 'en_US';
                u.TimeZoneSidKey = 'GMT';
                u.LanguageLocaleKey = 'en_US';
                u.EmailEncodingKey = 'UTF-8';
                system.debug(u);
                ul.add(u);
            }
        }
        insert ul;
        for(user uu : ul){
            uu.Alias = 'Methods';
            update uu;
        }
    }
}