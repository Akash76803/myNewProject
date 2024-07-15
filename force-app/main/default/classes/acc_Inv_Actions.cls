public class acc_Inv_Actions {
     @InvocableMethod(label = 'List of opportunity')
    public static list<opportunity> listop(list<string> ids){
        list<opportunity> oplist;
        try{
           string acid = ids[0];
        list<opportunity> oplist1 = [select id, AccountId, amount, name from opportunity where AccountId =: acid order by amount ASC limit 1 ];
        system.debug('list: '+ oplist1 );
        return oplist;  
        }
        catch(Exception e){
            system.debug('Error'+e.getMessage());
            return oplist; 
        }
          
      
    }
}