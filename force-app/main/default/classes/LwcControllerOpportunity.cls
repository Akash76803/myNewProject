public class LwcControllerOpportunity {
   
         @auraEnabled(cacheable=true)
    public static map<string, object> displayOpportunityAccountContactntData(String recordId){
        system.debug('Rec id: '+ recordId);
        map<string, object> returnmap = new map<string, object>();
       opportunity op = [select id, name, AccountId from opportunity where id =: RecordId];
        system.debug('OPP: '+ op);
        list<map<string, object>>conlist = new list<map<string, object>>();
        
        for(Contact con:[select id, FirstName, LastName, Account.name, email, fax from contact where Account.id =: op.AccountId]){
            conlist.add(new map<string, object>{
                'Name'=>con.FirstName+''+con.LastName,
                    'Id'=>con.id,
                    'Email'=>con.Email,
                    'Fax'=>con.Fax,
                    'accountname'=>con.Account.Name
                
            });
        }
        returnmap.put('Contact', conlist);
        return returnmap;
    }
    
    @auraEnabled
    public static void displayContact(list<contact> displayContact){
       system.debug('displayContact: '+ displayContact);
        update displayContact;
    }
    
    @AuraEnabled(cacheable=true)
    public static map<string, object> getInitialData(){
        Map<string, object> returnMap = new Map<string, object>();
        returnMap.put('languageOptions',CommonUtil.getLightningPickListValues('Select_Language__c','Contact'));
        return returnMap;
    }
}