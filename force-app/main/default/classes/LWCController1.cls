public class LWCController1 {
    
    @auraEnabled(cacheable=true)
    public static map<string, object> displayContactntData(){
        map<string, object> returnmap = new map<string, object>();
        list<map<string, object> > contactlist = new list<map<string, object> >();
        
        for(Contact con:[select id, FirstName, LastName, Account.name, email, fax from contact]){
            contactlist.add(new Map<string, object>{
                'Name'=>con.FirstName+' '+con.LastName,
                    'Email'=>con.Email,
                    'Fax'=>con.Fax,
                    'Account'=>con.Account.name
                    });
        }
        returnmap.put('contact', contactlist);
        return returnmap;
    }
    
     @auraEnabled(cacheable=true)
    public static map<string, object> displayOpportunityAccountContactntData(String recordId){
        system.debug('Rec id: '+ recordId);
        map<string, object> returnmap = new map<string, object>();
       opportunity op = [select id, name, AccountId from opportunity where id =: RecordId];
        system.debug('OPP: '+ op);
        list<map<string, object>>conlist = new list<map<string, object>>();
        
        for(Contact con:[select id, AccountId, FirstName, LastName, Account.name, Account.id, email, fax from contact where Account.id =: op.AccountId]){
            conlist.add(new map<string, object>{
                'Name'=>con.FirstName+''+con.LastName,
                    'Email'=>con.Email,
                    'Fax'=>con.Fax,
                    'Account'=>con.Account.Name
                
            });
        }
        returnmap.put('Contact', conlist);
        return returnmap;
    }
}