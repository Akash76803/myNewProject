public class OpportunityTestHelper {
    
    public static void test(list<Opportunity> newList){
        set<id> ids = new set<id>();
        /*  for(Opportunity op: newList ){
ids.add(op.Id);
}*/
        list<OpportunityLineItem> oli = [select id, name, OpportunityId from OpportunityLineItem where OpportunityId in: newList and opportunity.stagename = 'Closed Lost' ];
        if(oli.size()<=0){
            system.debug('List size: '+ oli.size() );
            for(Opportunity op:newList ){
                if(op.StageName== 'Closed Lost'){
                    op.StageName.addError('Please add at least 1 product'); 
                }
                
            }
        }
    }
    
    public static void updateStage(map<id, opportunity> newlist, map<id, opportunity> oldmap){
        double currentWonOppOLISize =0;
        double currentLostOppOLISize =0;
        set<id> wonAccId = new set<id>();
        set<id> lostAccId = new set<id>();
        list<opportunitylineItem> oliWonList = new list<opportunitylineItem>();
        list<opportunitylineItem> oliLostList = new list<opportunitylineItem>();
        
        for(opportunitylineItem oli: [select id, name, opportunityId, opportunity.stagename, opportunity.AccountId from opportunitylineItem where opportunityId in: newlist.keySet() and opportunity.stagename ='closed won']){
          system.debug('oli stage: '+ oli.opportunity.stagename +'Account-->: '+ oli.opportunity.AccountId);
            oliWonList.add(oli);
            wonAccId.add(oli.opportunity.AccountId);
        }
        currentWonOppOLISize = oliWonList.size();
        system.debug('currentWonOppOLISize: '+ currentWonOppOLISize +' '+ 'oliWonList: '+ oliWonList.size() +' '+ 'wonAccId: '+wonAccId);
     
        for(opportunitylineItem oli1: [select id, name, opportunityId, opportunity.stagename, opportunity.AccountId from opportunitylineItem where opportunityId in: newlist.keySet() and opportunity.stagename ='closed lost']){
           system.debug('oli1 stage1: '+ oli1.opportunity.stagename + 'Account1-->: '+  oli1.opportunity.AccountId);
            oliLostList.add(oli1);
            lostAccId.add(oli1.opportunity.AccountId);
        }
        currentLostOppOLISize = oliLostList.size();
        system.debug('currentLostOppOLISize: '+ currentLostOppOLISize +' '+ 'oliLostList: '+ oliLostList.size()+' '+ 'lostAccId:  '+lostAccId);
        
        list<Account> wonOli = new list<Account>();
        list<Account> lostOli = new list<Account>();
        list<opportunitylineItem> oliWonList1 = new list<opportunitylineItem> ();
        list<opportunitylineItem> oliWonList2 = new list<opportunitylineItem> ();
        list<opportunitylineItem> oliLostList1 = new list<opportunitylineItem> ();
        list<opportunitylineItem> oliLostList2 = new list<opportunitylineItem> ();
       
        //FOR CLOSED WON OP STAGE OLI'S
        for(Account ac: [select id, name,  (select id, accountId, stagename, name from opportunities ) from account Where id in: wonAccId ]){
            list<opportunity> oplists = new list<opportunity>();
            oplists = ac.opportunities;
            
            for(opportunity opOli: oplists){
                system.debug('oppid: '+ opOli.Id);
                for(opportunitylineItem olis: [select id, name, opportunityId, opportunity.stagename, Opportunity.Name, opportunity.AccountId from opportunitylineItem where  opportunity.id  =: opOli.Id And opportunity.stagename ='closed won']){
                    system.debug('stage: '+ olis.opportunity.stagename+'  '+'op name: '+ olis.opportunity.name);
                    oliWonList1.add(olis);
                }
            }
            for(Opportunity op1: oplists){
                for(opportunitylineItem olis: [select id, name, opportunityId, opportunity.stagename, Opportunity.Name, opportunity.AccountId from opportunitylineItem where  opportunity.id  =: op1.Id And opportunity.stagename ='closed lost']){
                    system.debug('stage: '+ olis.opportunity.stagename+'  '+'op name: '+ olis.opportunity.name);
                    oliWonList2.add(olis);
                }
            }
            ac.Closed_won_Oli__c =  oliWonList1.size();
            ac.Closed_lost_OLI__c =oliWonList2.size();
            system.debug('Closed_won_Oli__c: '+ ac.Closed_won_Oli__c +' '+'ac.Closed_lost_OLI__c: '+ ac.Closed_lost_OLI__c);
            wonOli.add(ac);
        }
        update wonOli;
                
        
        //For CLOSED LOST OPP STAGE OLI'S
        for(Account ac: [select id, name,  (select id, accountId, stagename, name from opportunities ) from account Where id in: lostAccId ]){
            list<opportunity> oplists = new list<opportunity>();
            oplists = ac.opportunities;
            for(opportunity opOli: oplists){
                for(opportunitylineItem olis: [select id, name, opportunityId, opportunity.stagename, Opportunity.Name, opportunity.AccountId from opportunitylineItem where  opportunity.id  =: opOli.Id And opportunity.stagename ='closed lost']){
                    system.debug('stage: '+ olis.opportunity.stagename+'  '+'op name: '+ olis.opportunity.name);
                    oliLostList1.add(olis);
                }
            }
            for(opportunity opps:oplists){
                for(opportunitylineItem olis: [select id, name, opportunityId, opportunity.stagename, Opportunity.Name, opportunity.AccountId from opportunitylineItem where  opportunity.id  =: opps.Id And opportunity.stagename ='closed won']){
                    system.debug('stage: '+ olis.opportunity.stagename+'  '+'op name: '+ olis.opportunity.name);
                    oliLostList2.add(olis);
                }
            }
            ac.Closed_lost_OLI__c =oliLostList1.size();
            ac.Closed_won_Oli__c = oliLostList2.size();
            system.debug('Closed_lost_OLI__c: '+ ac.Closed_lost_OLI__c+' '+'won oli: '+ac.Closed_won_Oli__c);
            lostOli.add(ac);
        }
        update lostOli;
        
    }
}