@RestResource(urlMapping ='/Account')
global class RestAPIExmple {
@httppost
    global static void postAccountData(){
        //create rest request variable to get request from callout
        RestRequest req = RestContext.request;
       
        //JSON-OBJECT conversion
       JsonParser parse = Json.createParser(req.requestBody.toString());
        
        map<string, object> requestMap = (map<string, object>)Parse.readValueAs(map<string, object>.class);
        
        Account acc = [select id, name from account where id =: string.valueOf(requestMap.get('Id'))];
        
        //=======FOR RESPONSE=============//
         ////create rest response variable to post request response from Webservice
        RestResponse res = RestContext.response;
        map<string, object> responsemap = new map<string, object>();
        
        responsemap.put('Name', acc.Name);
        Blob b = blob.valueOf(Json.serialize(responsemap));
        res.responseBody = b;
        res.addHeader('context-type', 'application/json');
    }
    
}