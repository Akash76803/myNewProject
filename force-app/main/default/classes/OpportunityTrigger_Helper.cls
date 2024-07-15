public class OpportunityTrigger_Helper  {
    //Sce 1
    //
    public static void update_StageTo_Prospecting(List<Opportunity> NewList ){
        
        for(Opportunity op : Newlist ){
            op.StageName = 'Prospecting';
        }
        
    }
    
    //Sce 2
    public static void update_StageTo_Qualification(List<Opportunity> Newlists, Map<Id, Opportunity> newMap, map<id, Opportunity> oldmap){
        //Here we validating backstage
        
        map<string, integer> stagevalue = new map<string, integer> {'Prospecting' =>1, 'Qualification' =>2, 'Needs Analysis' =>3,
            'Value Proposition' =>4, 'Exceptionally Aproved' =>5, 'Id. Decision Makers' =>6, 'Perception Analysis' =>7,
            'Proposal/Price Quote' =>8, 'Negotiation/Review' =>9, 'Closed Won' =>10, 'Closed Lost' =>11};
                for(opportunity op: newMap.Values()){
                    opportunity oldOps = oldmap.get(op.id);
                    if(stagevalue.containsKey(op.StageName) && stagevalue.containsKey(oldOps.StageName) &&
                       stagevalue.get(op.StageName) < stagevalue.get(oldOps.StageName)){
                           op.addError('Error: Stage can not be moved backward');
                       }
                }
        
        
        
        
        for(Opportunity opp : Newlists){
            if(Opp.stageName == 'Prospecting' && (opp.Qualification__c == '10th' ||opp.Qualification__c == '11th'||opp.Qualification__c == '12th')){
                opp.StageName = 'Qualification';
            }
        }
        for(Opportunity opp1:Newlists){
            if(opp1.Need_Analysis__c){
                Opp1.StageName = 'Need Analysis';
            }
        }
        for(Opportunity opp2:Newlists){
            if(opp2.Deal__c == 'Success'){
                opp2.StageName = 'Cloesed Won';
            }
            if(opp2.Deal__c == 'Failure'){
                opp2.StageName ='Closed Lost';
            }
        }
        
    }
    //Sce 3
    
    
}