public class IndianPostBranchController {
    
    public string postalPinCode{get;set;}
    public string Response{get;set;}
    
  public list<PostOfficeBranch> plist{get;set;}
    
    public void searchpostalBranches(){
        plist = new list<PostOfficeBranch>();
        
        if(postalPinCode != null && postalPinCode != ''){
            string endPointURL = 'https://api.postalpincode.in/pincode/' + postalPinCode;
            
            http httpobj = new http();
            httpRequest req = new httpRequest();
            
            req.setEndpoint(endPointURL);
            req.setMethod('GET');
            
            HttpResponse res = httpobj.send(req);
            Response = res.getBody();
            
            //create json parser
            system.JSONParser pParser = system.JSON.createParser(res.getBody());
            
            while (pParser.nextToken() != null){
                if(pParser.getCurrentToken() == jsonToken.FIELD_NAME && pParser.getText() =='message'){
                    pParser.nextToken();
                    system.debug('Json response message is...:'+ pParser.getText());
                }
                if(pParser.getCurrentToken() == jsonToken.FIELD_NAME && pParser.getText() =='Status'){
                    system.debug('Json response message is...:'+ pParser.getText());
                }
                
                if(pParser.getCurrentToken() == jsonToken.FIELD_NAME && pParser.getText() =='PostOffice'){
                     pParser.nextToken();
                    if(pParser.getCurrentToken() == jsonToken.START_ARRAY){
                        pParser.nextToken();
                        while(pParser.getCurrentToken() == jsonToken.START_OBJECT){
                            PostOfficeBranch branch = (PostOfficeBranch)pParser.readValueAs(PostOfficeBranch.Class);
                            plist.add(branch);
                            pParser.nextToken();
                        }
                    }
                }
            }
        }
    }
}