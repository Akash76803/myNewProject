@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"code":0,"message":"success","data":{"Id":242284,"Name":"Solanki","Email":"sachdev@Gmail.com","Token":"adb99574-55f0-4c07-8e61-937f53e95cba"}}');
        res.setStatusCode(200);
        return res;
    }
}