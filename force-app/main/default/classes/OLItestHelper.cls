public class OLItestHelper {
  /*
 public static void restricToInsertOLI(list<OpportunityLineItem> newList){
       
        map< id, OpportunityLineItem>olismap = new map <id, OpportunityLineItem>();
        for(OpportunityLineItem i : newList){
            olismap.put( i.OpportunityId, i);
            system.debug('========'+ olismap);
        }
        list<Opportunity> op = [select id, name, StageName from opportunity where id in: olismap.keySet() AND StageName = 'Closed Won'];
        
        if(op.size()>0){
            system.debug(op.size());
            for(OpportunityLineItem oli1 : newList){
                oli1.addError('You are not able to insert Product due to stage closed won');
            }
        }
        
    }

*/  
   
    
    public static void afterInsertUpdateAccount(map<id, OpportunityLineItem> newmap){
       
        //***********************************************************************//
        set<id> opset1 = new set<id>();
        set<id> opset2 = new set<id>();
        set<id> acset1 = new set<id>();
        set<id> acset2 = new set<id>();
        
        for(OpportunityLineItem oli: newmap.values()){
            system.debug('newmap: '+newmap.values());
           opset1.add(oli.OpportunityId);
        }
        system.debug('opset: '+ opset1+ ' '+ 'opset2: '+opset2 + ' '+ 'acset1: '+acset1 +' '+'acset2: '+acset2);
        for(opportunity wonOps:[select id, name, accountId from opportunity where id in: opset1]){
            
        }
        
        for(Account ac: [select id, name,(select id, name, accountId from opportunities)  from account where id =: newmap.values().opportunity.accountId  ]){
            
        }
        
        
    }
}





/*
map<id, OpportunityLineItem> olimap = new map<id, OpportunityLineItem>();
for(OpportunityLineItem i : newList){
olimap.put(i.OpportunityId, i);
}


 system.debug('newmapss:'+ newmap);
        set<id> opid = new set<id>();
        set<id>acset = new set<id>();
        list<account> aclist = new list<account>();
        double olisize =0;
        double wonOliSize = 0;
        for(OpportunityLineItem olis: newmap.Values() ){
            opid.add(olis.OpportunityId);
            system.debug('OPID:'+ olis.OpportunityId);
        }
        system.debug('Opportunity Id: '+ opid);
        
        for(opportunity op: [select id, name, accountId from Opportunity where id in: opid]){
            system.debug('Op: '+ op + '======');
            acset.add(op.accountId);
        }
        system.debug('Account Id: '+ acset);
        
        map<id,  double> olimasp = new map <id,  double>();
        map<id,  double> wonOliMaps = new map <id,  double>();
        for(opportunity opp: [select id, name, accountId,stageName,(select id, opportunityId, name from OpportunityLineItems ) from opportunity where accountId in: acset ]){
            if(opp.StageName == 'closed lost'){
                list<OpportunityLineItem> olis =opp.OpportunityLineItems;
                olimasp.put(opp.Id, olis.size());
                olisize = olisize + olis.size();
                system.debug('OPPID: '+ ' '+opp.Id+'LIST of OLI: '+ olis.size() +' '+ ' olisize:  '+olisize);
            }
            if(opp.StageName == 'closed won'){
                list<OpportunityLineItem> wonOlis =opp.OpportunityLineItems;
                wonOliMaps.put(opp.Id, wonOlis.size());
                wonOliSize = wonOliSize + wonOlis.size();
                system.debug('OPPID: '+ ' '+opp.Id+'LIST of OLI: '+ wonOlis.size() +' '+ ' wonOliSize:  '+wonOliSize);
            }
            
        }
        
        for(account ac:[select id, name from account where id in:acset]){
            ac.Closed_lost_OLI__c = olisize;
            ac.Closed_won_Oli__c = wonOliSize;
            system.debug('olisize: '+ olisize+'  '+'ac.Closed_lost_OLI__c: '+ac.Closed_lost_OLI__c+' '+' wonOliSize: '+ ac.Closed_won_Oli__c +' ' + 'wonOliSize: '+ wonOliSize);
            aclist.add(ac);
        }
        update aclist;
*/