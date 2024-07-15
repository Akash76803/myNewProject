global class CalloutEx {
    global static void DoPost(){
        Map<String,Object> reqBody = new Map<String,Object>();

        reqBody.put('Name', 'Solanki');
        reqBody.put('Email','sachdev@Gmail.com');
        reqBody.put('Password','123455');
        Http ht = new Http();
        HTTPRequest req = new HttpRequest();

        req.setHeader('Content-type','Application/Json');
        req.setEndpoint('http://restapi.adequateshop.com/api/authaccount/registration');
        req.setMethod('POST');

        req.setBody(Json.serialize(reqBody));
        System.debug('Serilize body'+JSON.serialize(reqBody));
        HttpResponse res =  ht.send(req);
        System.debug('Response'+res);
        If(res.getStatusCode()== 200){
            System.debug('Body :'+res.getBody() +'Message :'+res.getStatus());
        }

}
}