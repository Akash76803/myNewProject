public class OpportunityCountHelper {
    
    //=================AFTER INSERT TRIGGER===============================    
    public static void countOpportunityAfterInsert(list<Opportunity> newList){
        try{
            set<id> acset = new set<id>();
            list<account> aclist = new list<account>();
            
            For(Opportunity o: newList){
                acset.add(o.AccountId);
            }
            
            for(Account ac: [select id, name, Opportunity_counted_trigger__c,(select id, name from opportunities) from account where id in: acset]){
                
                ac.Opportunity_counted_trigger__c = ac.opportunities.size();
                system.debug('ac.opportunities.size(): '+ac.opportunities.size());
                aclist.add(ac);
                system.debug('aclist: '+aclist.size());
            }
            if(aclist.size()>0){
                update aclist;
            }  
        }
        catch(Exception e){
            system.debug('Error: '+ e.getMessage());
        }
        
    }
    
    //=================AFTER UPDATE TRIGGER=============================== 
    public static void countOpportunityAfterUpdate(list<Opportunity> newList, map<id, Opportunity> Oldmap){
        set<id> acnewset = new set<id>();
        set<id> acOldset = new set<id>();
        
        list<account> aclist = new list<account>();
        list<account> Oldlist = new list<account>();
        
        for(Opportunity Newop: newList ){
            Opportunity oldOp = Oldmap.get(Newop.Id);
            if(Newop.AccountId != oldOp.AccountId){
                acnewset.add(Newop.AccountId);
            }
        }
        
        for(Opportunity op:Oldmap.Values() ){
            acOldset.add(op.AccountId);
        }
        for(Account Newac:[select id, name, Opportunity_counted_trigger__c,(select id, name from opportunities) from account where id in: acnewset]){
            Newac.Opportunity_counted_trigger__c = Newac.opportunities.size();
            aclist.add(Newac);
        }
        update aclist;
        
        for(Account Oldac:[select id, name, Opportunity_counted_trigger__c,(select id, name from opportunities) from account where id in: acOldset]){
            Oldac.Opportunity_counted_trigger__c = Oldac.opportunities.size();
            Oldlist.add(Oldac);
        }
        update Oldlist; 
    }
    //=================BEFORE DELETE TRIGGER=============================== 

    //***************For OLI***********************
    public static void countOpportunityBeforerDelete(list<Opportunity> oldList, map<id, opportunity> oldmap){
        try{
            
        list<OpportunityLineItem> olilist = new  list<OpportunityLineItem>();
        for(OpportunityLineItem oli: [select opportunityId from OpportunityLineItem where opportunityId in: oldmap.keySet()]){
            olilist.add(oli);
            system.debug('olilist: '+ olilist.size());
        }
        if(olilist.size()>0){
            delete olilist;
            system.debug('olilist: '+ olilist.size());
        }
            
        } catch(exception e){
            system.debug('Error: '+ e.getMessage()+''+e.getLineNumber()+''+e.getCause()+''+e);
        }
        
    }
    //=================AFTER DELETE TRIGGER=============================== 
    public static void countOpportunityAfterDelete(list<Opportunity> oldList, map<id, opportunity> oldmap){
        set<id> acset = new set<id>();
         
        for(Opportunity op : oldList){
            acset.add( op.AccountId);
        }
        list<account> aclist = new list<account>();
        for(Account ac:[select id, name, Opportunity_counted_trigger__c,(select id, name from opportunities) from account where id in: acset]){
            ac.Opportunity_counted_trigger__c = ac.opportunities.size();
            aclist.add(ac);
        }
        update aclist;
    }
    
    //=================AFTER UNDELETE TRIGGER=============================== 
    public static void countOpportunityAfterUnDelete(list<Opportunity> newList, map<id, opportunity> newmap){
        set<id> acset = new set<id>();
        list<account> aclist = new list<account>();
        
        For(Opportunity o: newList){
            acset.add(o.AccountId);
        }
        
        for(Account ac: [select id, name, Opportunity_counted_trigger__c,(select id, name from opportunities) from account where id in: acset]){
            
            ac.Opportunity_counted_trigger__c = ac.opportunities.size();
            system.debug('ac.opportunities.size(): '+ac.opportunities.size());
            aclist.add(ac);
            system.debug('aclist: '+aclist.size());
        }
        if(aclist.size()>0){
            update aclist;
        }
        //********************for OLI****************
        system.debug('trigger.newMap' + trigger.newMap);
        try{
            list<OpportunityLineItem>olilist1 = new list<OpportunityLineItem>();
           for(OpportunityLineItem oli: [select Name, opportunityId from OpportunityLineItem where opportunityId in: newmap.keySet()]){
           
            system.debug('olilist: '+ oli.Name);
        }  
            system.debug('olilist: '+ olilist1.size());
            undelete olilist1;
            
        }catch(Exception ex){
            system.debug('Error: '+ ex.getMessage());
        }
        
    }
}