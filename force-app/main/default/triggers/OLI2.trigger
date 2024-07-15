trigger OLI2 on OpportunityLineItem (after insert) {
    set<id> opset = new set<id>();
    for(OpportunityLineItem oli: trigger.new){
        opset.add(oli.OpportunityId);  
    }
     map<id, double> CloseWonolimap = new map <id, double>();
    list<Opportunity> aclist = [select id, accountId,(select id, name from OpportunityLineItems) from opportunity where id in : opset];
    set<id>ids = new set<id>();
    for(Opportunity op: aclist){
        ids.add(op.AccountId);
        if(op.StageName == 'Closed Won'){
             CloseWonolimap.put(op.Id, op.OpportunityLineItems.size());
        }
      
    }
    
}
/*
 * map<id, double> CloseWonolimap = new map <id, double>();
    map<id, double> CloseLostolimap = new map <id, double>();
    system.debug('CloseWonolimap size: '+ CloseWonolimap);
     system.debug('CloseLostolimap size: '+ CloseLostolimap);
    double Wonsize;
    double Lostsize;
    set<id> acset = new set<id>();
     
    for(opportunity op : [select id, name, AccountId, StageName,(select id, name from OpportunityLineItems ) from opportunity where Id in: opset ]){
        acset.add(op.AccountId);
        if(op.StageName == 'Closed Lost'){
           Lostsize= op.OpportunityLineItems.size();
        }
        if(op.StageName == 'Closed Won'){
           Wonsize= op.OpportunityLineItems.size();
        }
    }
    
    list <account> aclist  = new list<account>();
    for(Account ac : [select id, name from account where id in: acset]){
       ac.Closed_won_Oli__c = Lostsize;
        ac.Closed_lost_OLI__c = Wonsize;
        aclist.add(ac);
    }
    
    update aclist;
    system.debug('Won size: '+ Wonsize);
    system.debug('Lost size: '+ Lostsize);
    system.debug('CloseLostolimap size: '+ CloseLostolimap);
    system.debug('CloseWonolimap size: '+ CloseWonolimap);
    
*/