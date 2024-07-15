public class mainClass {

    public static void testing(){
        integer count = 14;
        integer x = 0;
        for(integer i = 1; i<count; i++){
            x=i;
            subClass_1.isStop = true;
            list<Account> acl = subClass_1.myAccount();
            for(account ac: acl ){
                x=i;
                system.debug('list count' + x);
            }
            system.debug('i is less than count' + x);
            system.debug('is stop:'+ subClass_1.isStop);
        }
        system.debug('i is equal to count');
        
    }
}