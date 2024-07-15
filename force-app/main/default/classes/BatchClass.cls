public class BatchClass implements database.Batchable <sObject> {
    public database.QueryLocator start(Database.BatchableContext bc){
        return database.getQueryLocator('select id, name from account');
    }
    
    public void execute(database.BatchableContext bc, list<Account> newlist){
        
    }
    
    public void finish(database.BatchableContext bc){
        
    }
}