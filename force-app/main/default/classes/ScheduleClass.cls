public class ScheduleClass implements Schedulable {
 
    public void execute(SchedulableContext sc){
        BatchClass obj = new BatchClass();
        database.executeBatch(obj);
        
    }
}