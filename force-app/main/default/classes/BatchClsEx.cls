public class BatchClsEx implements Database.Batchable <sObject>{
    public database.QueryLocator start (database.BatchableContext bc){
        return database.getQueryLocator('select id, name, industry, ownership from account');
    }
    public void execute (Database.BatchableContext bc, list<Account> alist){
        list<account> al = new list<Account>();
        for(Account a: alist){
            a.Industry = 'Banking';
            a.Ownership = 'Public';
            al.add(a);
        }
        update al;
    }
    public void finish(Database.BatchableContext bc){
        system.debug('batch executed successfully..!');
    }

}