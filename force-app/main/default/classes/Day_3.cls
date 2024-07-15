public class Day_3 {

    public static void soql_Ex(){
        
        list<account> simpleList = [select id, name, Industry from account where Industry = 'Agriculture' And name like 'Akash Gaikwad test1'];
			System.debug(simpleList);        
        //Parent to child std obj
        list<account> alist = [select id, name,(select id, name from contacts) from account];
        
        //custom object p-c  Student__c
        list<Branch__c> objeclist = [select id, name,(select id, name from Students__r) from Branch__c];
        
        //child to parent std obj
        list<contact> C_P = [select id, name, AccountId, account.name, account.industry from contact];
        
        //Custom object c-p
        list<Student__c> slits = [select id, name, Branch__r.name  from Student__c];
        
        //without variable
        list<AggregateResult> res_1 =[select count(id), Avg(AnnualRevenue), MIN(AnnualRevenue),MAX(AnnualRevenue), Industry from account group by Industry having industry = 'Agriculture' ];
        system.debug('Aggregate Result: '+ res_1); 
        
        //with variable
        list<AggregateResult> res_2 =[select count(id), Avg(AnnualRevenue)s, Industry from account group by Industry having industry = 'Agriculture' ];
        system.debug('Aggregate Result: '+ res_2);
        for( AggregateResult v: res_2 ){
            system.debug('Variable Result:->>> '+v.get('s'));
        }
    }
}