public class CaseObj_Handler {
    public static void caseOrigin(List<Case> NewList){
        for(Case c: NewList){
            if(c.Origin == 'Email'){
                c.Status = 'New';
                c.Priority = 'Medium';
            }
        }
        
    }

}