public class Apex_Invocable_Method {
   /*
		@InvocableMethod(label= 'Get Account Name'
                     description = 'Return The list of Account Name Corrosponding to specified IDs '
                     category = 'Account'
                    )
    public static list<string> getAccountName(list<string> ids){
        list<string> account_Name = new list<string>();
        list<account> accounts = [select name from account where id IN : ids];
        for(account acc : accounts){
            account_Name.add(acc.name);
        }
        return account_Name;
*/
    
    @InvocableMethod(label= 'Delete Related Opportunity'
                     description = 'Delete Related Opportunity '
                     category = 'Account'
                    )
    public static void getAccountName(list<string> ids){
       
        list<Opportunity> oplist = [select id from Opportunity where AccountId =: ids AND StageName = 'Closed Won'];
       delete oplist;
    }

}