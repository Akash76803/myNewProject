@RestResource(urlMapping ='/opportunity/*')
Global class OpportunityRestAPI {
    // https://plus91labsllp-1b-dev-ed.develop.my.salesforce.com/services/apexRest/opportunity
    
    @httppost
    global static void doPost(){
        list<Opportunity> opl = new list<Opportunity>();
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        try{
            list<wrapperClass> wraplist =  (list<wrapperClass>) JSON.deserialize(req.requestBody.toString(), list<wrapperClass>.class);
            for(wrapperClass obj : wraplist){
                Opportunity op = new Opportunity();
                op.Name = obj.name;
                op.CloseDate = obj.closedDate;
                op.StageName = obj.satge;
               // op.LeadSource = obj.leadSource;
               // op.AccountId = obj.accountId;
                opl.add(op);
            }
            insert opl;
            
            res.addHeader('context-type', 'Application/Json');
            res.statusCode =200;
            map<string, object> opmap = new map<string, object>(); 
            for(opportunity o : opl){
                opmap.put('Name', o.Name);
                opmap.put('message', 'Success');
            }
            blob b = blob.valueOf(Json.serialize(opmap));
            res.responseBody= (b);
        } 
        catch(Exception e){
            system.debug(e.getMessage());
            system.debug(res.statusCode);
        }
        
        
    }
    public class wrapperClass{
        public string name;
        public date closedDate;
        public string satge;
        public string leadSource;
        public Id accountId;
        
    }
}