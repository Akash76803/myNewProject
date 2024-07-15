public class Day_1_Class {
    public static list<Account> InsertAccount(String name, string phone,
                                              string AccountNumber, string AccountSource, string Country)
    {
        list<Account> Aclist = new List<Account>();
        
        Account Ac = new Account ();
        Ac.Name = name;
        Ac.Phone = phone;
        Ac.AccountNumber = AccountNumber;
        Ac.AccountSource = AccountSource;
        Ac.Country__c = Country;
        
        Aclist.add(Ac);
        
        insert Aclist;       
        System.debug('Account Inserted Successfully: '+'Account ID'+ Ac.Id+' '+'Account Name'+ Ac.name +' '+'Account Phone'+ Ac.Phone+' '+'Account Number'+ Ac.AccountNumber+' '+'Account Source'+ Ac.AccountSource+' '+'Account Country'+ Ac.Country__c );
        return Aclist;
    }
    
}