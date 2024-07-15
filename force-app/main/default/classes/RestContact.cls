@RestResource(urlMapping ='/createContact')
global class RestContact {
    
    @HttpPost
    global static void createContacts(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        try{
            map<string, object> requestMap = (map<string, object>) JSON.deserializeUntyped(req.requestBody.toString());
            Contact con = new Contact();
            con.FirstName = String.valueOf(requestMap.get('FirstName'));
            con.LastName = string.valueOf(requestMap.get('LastName'));
            con.Phone = string.valueOf(requestMap.get('Phone'));
            insert con;
            
            map<string, object> responsemap = new map<string, object>();
            responsemap.put('Id', con.Id);
            responsemap.put('Message', 'Success');
            
            res.responseBody = blob.valueOf(JSON.serialize(responsemap));
            res.statusCode = 201;
        }catch(exception ex){
            map<string, object> responsemap = new map<string, object>();
            responsemap.put('Id', 'null');
            responsemap.put('Message', ex.getMessage());
        }
    }
    
}