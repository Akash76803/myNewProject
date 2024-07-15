public class EmailHelper {
    
    public static void updateOppStage(map<id, EmailMessage> newmap){
        system.debug('sdfghj');
        list<Opportunity> oli = new list<Opportunity>();
        system.debug(''+ newmap.KeySet());
        set<id> ids = new set<id>();
        for(EmailMessage emg : newmap.Values()){
            ids.add(emg.RelatedToId);
        }
        system.debug('======='+ ids);
        for(Quote q: [select id, name, OpportunityId  from Quote where id in : ids]){
            system.debug('q: '+q.Id+' '+ q.OpportunityId);
            Opportunity op = new Opportunity();
            op.StageName = 'Proposal/Price Quote';
            op.Id = q.OpportunityId;
            oli.add(op);
        }
        
        system.debug(oli);
        update oli;
        
    }
}