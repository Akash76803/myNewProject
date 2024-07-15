public class AccountHandler {

    public static void  insertAccount(integer value ){
        list<account> addAccounts = new list<account>();
        
        integer N = 1;
        while(N<=value){
            Account acc = new Account();
            acc.name= 'Acme Inc N'+ N;
            acc.AccountNumber='A000n' + N;
            addAccounts.add(acc);
            system.debug(addAccounts);
            N= N+1;
        }
        insert addAccounts;
    }
     
}
/*
public static Account insertNewAccount(String Accountname ){
        try {
            Account newacct = new Account ();
            newacct.Name = 'Accountname';
            insert newacct;
            return newacct;
        } catch (DmlException e) {
            System.debug('A DML exception has occurred: ' +
                         e.getMessage());
            return null;
        }
    }
*/