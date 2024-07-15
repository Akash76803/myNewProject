public class BatchClassExample implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select id, name, industry, type, status__c, CreatedDate from account where createdDate < LAST_N_DAYS:1');
    }
    
    public void execute (Database.BatchableContext bc, List<Account> alist){
       List<Account> aclist = new list<Account>();
        for(Account a : alist){
            if(a.Industry == 'Apparel' || a.Industry == null){
                a.Industry = 'Banking';
                aclist.add(a);
                system.debug('list to update: '+ a.Industry);
            }  
        }
        system.debug('Size of list: '+ aclist.size());
        update aclist;
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('Your batch execute successfully');
    }
}