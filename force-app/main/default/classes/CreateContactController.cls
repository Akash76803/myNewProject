public class CreateContactController {

    public String CreateContactController { get; set; }

    public String Create_Contact_with_account { get; set; }
	
    public flow.Interview.Create_Contact_with_account contactRecCrationFlow{get;set;}
    
    public string getconRecId(){
        if(contactRecCrationFlow <> null){
            return contactRecCrationFlow.ConId ;
        }
        return null;
    }
    
    public PageReference getCreatedRecord(){
        PageReference obj = new PageReference('/'+ getconRecId());
        obj.setRedirect(true);
        return obj;
    }
}