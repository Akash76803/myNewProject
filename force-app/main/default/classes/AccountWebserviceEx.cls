Global class AccountWebserviceEx {
    @future(callout = true) global static void acc(list <id> ids){
        List<Account> al = new list<Account>();
        For(Account ac: [select id, name, Response__c, Phone, Email__c from account Where id in: ids]){
            
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('http://restapi.adequateshop.com/api/authaccount/registration');
            request.setMethod('POST');
            
            
            map<string, object> Jsonmap = new  map<string, object>();
            Jsonmap.put('Name' , ac.Name);
            Jsonmap.put('Password' , ac.Phone);
            Jsonmap.put('Email' , ac.Email__c);   
            
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setBody(Json.serialize(Jsonmap));
            HttpResponse response = http.send(request);
            system.debug('alist: '+ response);
            if(response.getStatusCode() == 200) {
                System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
                
                ac.Response__c = response.getBody();
                system.debug('alist: '+ ac.Response__c );
                al.add(ac);
                system.debug('alist: '+ al);
                
                
            } else {
                System.debug(response.getBody());
            }
        }
        update al;
    } 
    
}