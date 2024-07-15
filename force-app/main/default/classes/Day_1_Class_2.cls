public class Day_1_Class_2 {
    public static void sobject (){
        sObject obj;
        obj = new Account();
        obj = new Contact();
        obj = new opportunity();
       
        
        obj.put('Name', 'Akash Gaikwad');
         Object objvalue = obj.get('Name');
        obj.put('Phone', '7709400101');
     system.debug('==========='+ obj.get('Name'));   
    }

}