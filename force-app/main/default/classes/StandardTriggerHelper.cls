public class StandardTriggerHelper {

    public static void beforeDelete(map<id, Standard__c> oldmap){
       set<id> ids = new set<id>();
        system.debug('get id'+ ids);
        for(id st: oldmap.keySet()){
            ids.add(st);
        }
        list<student__c> getStudent = [select id, name, Standard__c from student__c where Standard__c in: ids];
        system.debug('get student'+ getStudent);
        delete getStudent;
    }
}