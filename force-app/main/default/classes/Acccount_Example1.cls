public class Acccount_Example1 {

    @AuraEnabled(cacheable=true)
    public static list<account> displayAccWithcon(string searchkey){
        string str = '%'+ searchkey +'%';
        return [select id, name, phone from account where name like: str];
    }

}