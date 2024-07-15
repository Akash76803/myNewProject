public class ContactFutureHelper {
    @future(Callout=true)
    public static void doPost(list<id>ConId){
        list<contact> conlist = new list<contact>();
        for(Contact c: [select id, name, Email, Phone, Description from contact where id in: ConId]){
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('http://restapi.adequateshop.com/api/authaccount/login');
            request.setMethod('POST');
            
            map<string, object> Jsonmap = new  map<string, object>();
            
            Jsonmap.put('email', c.Email);
            Jsonmap.put('password', c.Phone);
              
            
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setBody(Json.serialize(Jsonmap));
            system.debug('JSON: '+ Json.serialize(Jsonmap));
            
            HttpResponse response = http.send(request);
            system.debug('alist: '+ response);
            
             if(response.getStatusCode() == 200) {
                System.debug('The status code returned was expected: ' + response.getStatusCode() + ' ' + response.getStatus());
                
                c.Description = response.getBody();
                system.debug('alist: '+ c.Description );
                conlist.add(c);
                system.debug('alist: '+ conlist);
                
                
            } else {
                System.debug(response.getStatus());
            }
        }
        Update conlist;
    }
    
}