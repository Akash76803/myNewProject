public class Contact_example_1 {
    public static void getcontact(){
        list<string> aclist = new list<string>();
        for(account con : [select id, name from account ]){
            aclist.add(con.Name);
            system.debug( '++++++++'+ con.name + '++++++');
        }
        
        for(Contact con: [select id, name from Contact where account.name in: aclist]){
            system.debug('*********'+con.Name+'********');
        }
    }
}