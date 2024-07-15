public class Map_Example {
   
    public static  void mapex(){
      list<Account> listac = [select id, name, rating, type,Phone,Fiscal_Year__c,Description,(select id, name, Amount__c from contacts ) from account];
        map<string, list<contact>> accmap = new map<string, list<contact>>();
        for(Account a : listac){
            list<contact> con = a.contacts;
            system.debug(a.Name);
              system.debug(a.Phone);
              system.debug(a.Fiscal_Year__c);
            system.debug(a.Description);
            accmap.put(a.name, a.contacts);
            system.debug('Map Result: '+ accmap);
        }
         //return accmap;
       
      /*  
        map<integer, string> mapex = new  map<integer, string>();
        mapex.put(1,'MH');
        mapex.put(2,'TN');
        mapex.put(3,'BIHAR');
        mapex.put(4,'MP');
        mapex.put(5,'UP');
        system.debug(mapex);*/
       
    }
    
    
}