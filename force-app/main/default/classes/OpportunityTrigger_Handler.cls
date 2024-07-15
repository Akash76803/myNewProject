public class OpportunityTrigger_Handler {
    /* public static void trackHistory(map<id, opportunity>NewMap, map<id, opportunity> oldmap){
public static void trackHistory1(map<id, account>NewMap, map<id, account> oldmap){
list<History_tracking__c> hisList = new list<History_tracking__c> ();
for(Account newac : [select id, name, Total_Opportunity_Amount__c, Rating from Account where id in: NewMap.keySet()]){
Account oldAcc = oldmap.get(newac.id);
if(oldAcc.Rating!= newac.Rating){
History_tracking__c obj = new History_tracking__c();
obj.Rating__c = newac.Rating;
obj.Name = newac.Name;
obj.Total_Opportunity_Amount__c = newac.Total_Opportunity_Amount__c;
hisList.add(obj);
}
insert hisList;
}
}


list<AggregateResult> opstageClosedWonCount = [select Count(id)cou, stagename from opportunity where id in:newlist  Group by stagename having stagename = 'Closed Won'];
list<AggregateResult> opstageClosedLostCount = [select Count(id)cou, stagename from opportunity where id in:newlist Group by stagename having stagename = 'Closed Lost'];
//list<Account> alist = [select id, name from account where id in:newlist];
for(opportunity o : newlist){
if(o.stagename != oldmap.get(o.id).stagename){
for(AggregateResult num : opstageClosedWonCount){
for(Account ac: [select id, name, Closed_Lost_Opportunity__c, Closed_Won_Opportunity__c from account]){
if(ac.Id == o.AccountId){
ac.Closed_Won_Opportunity__c = ac.Closed_Won_Opportunity__c + (Decimal)num.get('cou');
system.debug('Closed_Won_Opportunity:  '+ ac.Closed_Won_Opportunity__c );
}
}

}

for(AggregateResult num : opstageClosedLostCount){
for(Account ac: [select id, name, Closed_Lost_Opportunity__c, Closed_Won_Opportunity__c from account]){
ac.Closed_Won_Opportunity__c = (Decimal)num.get('cou');
system.debug('Closed_Won_Opportunity:  '+  ac.Closed_Won_Opportunity__c  );
}
}
}

system.debug('Expression not executed');

}
*/  
    
    public static void updateAccount(map<id, opportunity> newmaps){
        system.debug('test:    ' + newmaps);
        list<Account> Aclist = new list <Account> ();
        for(opportunity op : [select id, name, AccountId, StageName from Opportunity where AccountId in : newmaps.keySet()]){
            for(Account ac : [select id, name, description from Account where id in: newmaps.keySet()]){
                ac.Alert_Note__c = 'Current Opportunity Stage'; 
                Aclist.add(ac);
            }
        }
         system.debug('test:    ' + Aclist);
        Update Aclist;
       
    }
}