public class QueryClass {
    
    public static map<string, list<contact>> displayResult(string searchword){
        map<string, list<contact>> conmap = new map<string, list<contact>> ();
        list<contact> NewConlist = new list<contact>();
        String newSearchText = '%'+searchword+'%';
        list<account> aclist = [select id, name from account where name like: newSearchText limit 10];
        list<contact> cons = [select id, name, AccountId, Account.name from contact where AccountId in:aclist];
        
        for(Contact con: cons){
            NewConlist.add(con);
            conmap.put(con.account.name, NewConlist );
        }
        
        system.debug('cons :'+cons);
        system.debug('accList :'+aclist);
        system.debug('map############: '+ conmap);
        return conmap;
    }
    
    public static void createContact(string searchword){
        list<Account> ac = [select id, name, createdDate,(select id, name from contacts where AccountId ='') from Account order by createdDate DESC limit 3];
        list<id> ids = new list<id>();
        String newSearchText = '%'+searchword+'%';
        
        
        for(Account a: ac){
            contact cont = new contact();
            cont.LastName = a.Name;
            cont.AccountId = a.id;
            insert cont;
        }
    }
}