@RestResource(urlMapping='/api/Account/*')
global with sharing class MyFirstRestAPIClass
{
    @HttpGet
    global static list<Account> doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
      //  String AccNumber = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
       list< Account> result = [SELECT Id, Name, Phone, Website FROM Account ];
        return result;
    }
}