public class OpportunityLineItem_Helper {

    public static void UpdateOpportunityStageTo_ValuePreposition(list<OpportunityLineItem> NewList){
       set<Id> oppid = new set <Id>();
        list<opportunity> updateStage = new list<opportunity>();
        for(OpportunityLineItem oli  : NewList){
           oppid.add(oli.OpportunityId);
           
        }
        system.debug('Opp ids: '+ oppid);
        for(id opp: oppid){
            for(opportunity op : [select id, name, StageName, Need_Analysis__c from opportunity where id in : oppid]){
                op.StageName = 'Value Proposition';
                op.Id = opp;
                updateStage.add(op);
            }
        }
         
        system.debug('Account ids: '+ updateStage);
      update updateStage;
    }
}