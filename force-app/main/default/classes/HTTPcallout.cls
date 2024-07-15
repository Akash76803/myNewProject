public class HTTPcallout {
    @future(callout=true)
    public static void doPost(){
        system.debug('alist: ');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.postalpincode.in/pincode/423602');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        system.debug('alist: '+ response);
        system.debug('response : '+response.getBody());
        List<object> Listobj = (List<object>)JSON.deserializeUntyped(response.getBody());
        system.debug('Listobj : '+Listobj);
        
        map<string, object> mapspincode;
        list<object> liststring = new list<object>();
        for(object obj : Listobj){
            Map<string,object> mapobejct = (Map<string,object>)obj;
            system.debug('mapobejct : '+mapobejct);
             liststring.add(mapobejct.get('id'));
        }
        system.debug('liststring: '+ liststring);
        
        if(response.getStatusCode() == 200) {
            System.debug('The status code returned was expected: ' + response.getStatusCode() + ' ' + response.getStatus());
            
            
            
        } else {
            System.debug(response.getStatus());
        }
        
        
    }
    
}