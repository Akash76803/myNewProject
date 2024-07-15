public class ContactTrigger_Handler {

 
	 public static void getAccount(list<Contact> newContact){
     
       list <Account> ac1 = new list<Account>();
        for(contact c: newContact ){
            for(integer counter =1; counter<= c.Enter_Number__c; counter++){
            Account ac = new Account();
            ac.Name =c.LastName;
            ac.Id = c.AccountId;
            ac1.add(ac);
            }
           
        }
        insert ac1;
        
    }
 /*
 
    public static void CloneAfterInsertAccounts(list<Contact> newContact){
        
           List<contact> colist1 = new list<contact>();
        Contact conobj = new Contact();
             conobj.LastName = ' trigger record';
        	conobj.MobilePhone = '9890164660'; 
        colist1.add(conobj);
        insert colist1;
    }*/
    public static void beforeupdateop(map<id, contact> conmap){
        List<Opportunity> oplist = new list<opportunity>();
        for(Contact con: [select id, name, LeadSource,(select id, name,Amount from opportunities) 
                          from contact where id in:conmap.keySet()])
        {
            list<opportunity> opps = con.opportunities;
            for(Opportunity op: opps){
                if(con.LeadSource=='Phone Inquiry'){
                    op.Amount = 2000;
                    oplist.add(op); 
                }
               
            }
        }
        update oplist;
    }
    
    public static void afterInsertUpdateOperation(map<id, contact> conmap, map<id, contact> oldmaps){
        list<History_tracking__c> hisList = new list<History_tracking__c> ();
        for(contact con : [select id, name,LastName, MobilePhone from contact where id in:conmap.keySet()]){
            contact cons = oldmaps.get(con.Id);
            if(cons.MobilePhone != con.MobilePhone ){
                 History_tracking__c obj = new History_tracking__c();
                obj.Contact__c = con.Id;
                obj.Name = con.LastName;
                obj.New_Mobile_number__c = con.MobilePhone;
                obj.Old_mobile_number__c = cons.MobilePhone;
                hisList.add(obj);
            }
           insert hisList;
        }
    }
    public static void Check_Duplicate(list<contact> conlist){
        list<contact> clist = new list<contact>();
        set<string> conset = new set<string>();
       
        for(contact ac: conlist){
            conset.add(ac.Name);
        }
        
    }
}