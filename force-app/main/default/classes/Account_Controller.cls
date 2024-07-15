public class Account_Controller {
    @AuraEnabled(cacheable=true)
    public static list<account> getAccount(){
        return[select id, name,rating from account];
    }

}