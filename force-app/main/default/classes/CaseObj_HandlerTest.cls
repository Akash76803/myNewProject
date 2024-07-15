@isTest
public class CaseObj_HandlerTest {

    @isTest
    public static void dispay(){
        case obj = new case();
        obj.Origin ='Email';
        obj.Status = 'Working';
        obj.Priority ='Low';
        obj.Type = 'Mechanical';
        obj.Reason ='Other';
        insert obj;
        system.debug(obj);
    }
}