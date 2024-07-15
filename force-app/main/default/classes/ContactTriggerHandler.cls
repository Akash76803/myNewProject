public class ContactTriggerHandler {
    //SCENARIO-> WHEN CONTACT WITH PRIMARY CHECKBOX TRUE IF WE DELETE IT, UPDATE LAST CREATED CONTACT TO PRIMARY,
    // OF THAT DELETED CONTACT ACCOUNTS RELATED CONTACT
    // 
    // =====================BEFORE DELETE=========================================//
    public static void updateConId(list<Contact> olist){
        
        system.debug('OldList:  '+ olist);
        List<Account> alists = new list<Account>();
        List<Contact> css = new list<Contact>();
        Set<id> acid =  new set<id>();
        Set<id> acid1 =  new set<id>();
        
        //looping over oldlist and adding accountid in set
        for(Contact con: olist){
            system.debug('OldList:  '+ con.Primary_Contact__c +' '+ con.Id);
            if(con.Primary_Contact__c){
                acid.add(con.AccountId);
            }
        }
        
        //looping over oldlist and adding deleted contact id in account for ref.
        list<Account> alsit = [select id, name from account where id in:acid];
        for(Contact c: olist){
            for(Account a:alsit){
                a.subject__c =  c.Id;
                alists.add(a);
            }  
        }
        
        //looping over alists and add id in set
        for(Account a: alists){
            acid1.add(a.Id);
        }
        
        //getting contacts of account which are refferd contact id.
        list<contact> cs =[select id, name, Primary_Contact__c from contact where AccountId in : acid1 and Primary_Contact__c = false Order by createdDate DESC Limit 1];
        system.debug(cs);
        
        //looping over cs list to update primary contact checkbox true in contact object.
        for(Account sa : alists){
            for(Contact sc : cs){
                sc.AccountId = sa.Id;
                sc.Primary_Contact__c = true;
                css.add(sc);
            }
        }
        system.debug(css);
        update css;
        
        //looping over cs list to update primary contact field  in account object.
        List<Account> alist = new list<Account>();
        for(Contact sc1 : css){
            for(Account ass : alists){
                ass.Primary_Contact__c = sc1.id;
                alist.add(ass);
            }
        }
        system.debug(''+ alist );
        update alist;
    }
    
    
    //===============================Before Update================================================================
    
    public static void updatePrimaryCheckbox(List<contact> newlist, map<id, contact> newmap, map<id, contact> oldmap ){
        list<Account> Acclists = new list<Account>();
        list<contact> cc = new list<contact>();
        set<Id> accId = new set<Id>();
        set<Account> accId1 = new set<Account>();
        for(Contact c1: newmap.Values()){
            Contact oldrec = oldmap.get(c1.id);
            if(c1.Primary_Contact__c != oldrec.Primary_Contact__c){
                for(Contact c : newlist){
                    
                    system.debug('Newlist:  '+newlist );
                    if(c.Primary_Contact__c){
                        accId.add(c.AccountId);
                        for(contact cn :[select id, name, AccountId, Primary_Contact__c from contact where AccountId in: accId And Primary_Contact__c = true]){
                            cn.Primary_Contact__c = false;
                            cc.add(cn);
                            system.debug('Primary_Contact__c; '+ cn.Primary_Contact__c);
                            for(Account a : [select id, name, Primary_Contact__c from Account ] ){
                                if(a.id == c.AccountId){
                                    a.Primary_Contact__c = c.id;
                                    accId1.add(a);
                                    system.debug('Primary_Contact__c; '+ a.Primary_Contact__c);
                                }
                                
                            }
                        }
                    }
                } 
            }
        }
        
        
        update cc;
        system.debug('Primary_Contact__c; '+cc);
        Acclists.addAll(accId1);
        update Acclists;
        
    }
    //after update
    public static void updateAccDescription(map<id, contact> newmap){
        
    }
    
    
    
    
    
    
    
}