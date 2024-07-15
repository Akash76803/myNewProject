public class SIClass {
    public double rate{get;set;}
    public double amount{get;set;}
    public integer period{get;set;}
    public double earning{get;set;}
     public string Save{get;set;}
    
    public void find(){
        if(Save== 'Status'){
        earning = (amount * rate * period)/100 ; 
        }
    }
    
        
        
        
}