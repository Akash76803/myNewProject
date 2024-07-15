@isTest
public class UpdateAccContactHelperTest {

    @isTest
    public static void createAccount(){
        Account ac = new Account();
        ac.Name = 'Akash Gaikwad';
        ac.Enter_Number__c = 1;
        insert ac;
        
        
        contact con = new contact ();
        con.AccountId = ac.Id;
        system.debug('AccId'+con.AccountId);
        con.FirstName = 'ABC';
        con.LastName ='xyz';
        insert con;
        update ac;
        system.debug('con'+ con);
        system.debug('ac'+ ac);
       
        opportunity op = new opportunity();
        op.Name = 'xyz';
        op.StageName = 'closed won';
        op.CloseDate = system.today()+1;
        op.AccountId = ac.Id;
        op.Amount = 1234567.00;
        insert op;
       
    }
    
    
}