public class OpportunityController {
    public String opportunityId{get;set;}
    public Opportunity optObj{get;set;}
    public OpportunityController() {
        optObj = new Opportunity();
    }  
    @AuraEnabled(cacheable=true)    
    public static List<Opportunity> getOpportunity(){
        return [select id,name,stagename,Amount from Opportunity ];
    }
    @AuraEnabled
    public static List<Opportunity> getOpportunityRecordsList(){
        return [select id,name,stagename,Amount from Opportunity limit 10];
    }
    public pageReference retrieveOpportunityDetail(){
        if(opportunityId!=null){
             optObj = [select id,name,stagename,Amount from Opportunity where id=:opportunityId];
            
        }       
		return null;        
    }


}