public class Account_Example_2 {
   
    public static void test(){
    List<Account> acctList = new List<Account>();

for(Account acct: [SELECT Id, Name FROM Account WHERE Name like '% d %']){
    acct.Name = acct.Name.remove('d');
    acctList.add(acct); 
}
        

update acctList;
        system.debug('result: '+ acctList);
    }

    }