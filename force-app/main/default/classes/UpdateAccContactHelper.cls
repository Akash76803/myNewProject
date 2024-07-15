public class UpdateAccContactHelper {
    
    public static void deleteContact( map<id, account>newmap){
        
        Decimal totalContact = 0;
        integer newrecvalue =0;
        set<id>acSet = new set<id>();
        list<contact> totalContactList = new list<contact>();
        list<contact> deleteConList1 = new list<contact>();
              list<contact> cnlist = [select id, lastname, accountId, account.Enter_Number__c, createdDate from contact];
        system.debug('Contact data: '+ cnlist);
        for(contact c: [select id, lastname, accountId, account.Enter_Number__c, createdDate from contact where accountId in: newmap.keySet()   ] ){
            system.debug(c);
            totalContactList.add(c);
            totalContact = totalContactList.size();
            newrecvalue = integer.valueOf(c.account.Enter_Number__c);
            system.debug('totalContact--> '+totalContact +'account.Enter_Number__c '+ c.account.Enter_Number__c);
            acSet.add(c.accountId);
            system.debug('acSet--> '+acSet);
        }
        
        //getting contact of value in newrecvalue
        for(contact cc: [select id, name, accountId from contact where accountId in:acSet limit : newrecvalue ]){
            system.debug('cc--> '+cc);
            deleteConList1.add(cc);
            system.debug('deleteConList1--> '+deleteConList1.size());
        }
        if(deleteConList1.size()<= totalContact)
        delete deleteConList1;
    }
    
    
    public static void getOpportunityAmount(list< account> newlist){
        double opportunityAmount = 0;
        for(Account ac: newlist){
            for(opportunity op: [select id, name, stagename, amount, accountId, account.Opportunity_Ammount__c from opportunity where accountId =: ac.Id]){
                if(op.Amount != null){
                    opportunityAmount = op.Amount + opportunityAmount;
                    ac.Opportunity_Ammount__c = opportunityAmount;
                    system.debug('Opportunity Amount: '+ opportunityAmount +'  '+ 'Opportunity_Ammount__c : '+ op.account.Opportunity_Ammount__c );
                }
            }
            
        }
    }
}