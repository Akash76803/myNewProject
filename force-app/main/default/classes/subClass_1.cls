public class subClass_1 {
    
    public static boolean isStop = false;
    
    public static string firstName= 'akash';
    public static string lastName= 'Gaikwad';
    
    public static string DynamicInput(string fn, string ln){
        return fn +' '+ ln;
    }
    
    public static list<Account> myAccount(){
        
        list<account> acList = new list<account>();
        for(account a:[select id, name from account limit 10]){
            String sizeString = a.name;
            Integer maxSize = 15;
            if(sizeString.length() > maxSize ){
                sizeString = sizeString.substring(0, maxSize);
                system.debug(sizeString);
            }
          //  a.name = 'Updated '+a.name ;
          //  aclist.add(a);
        }
        update acList;
        return acList;
    }
}