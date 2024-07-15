public class SOQL_EXAMPLE_1 {
    
    public static void account(){
        list<account> p=[select Id,Name from Account Where Name='Akash Gaikwad' or Name='Amit singh'];
        
        list<Contact> s=[select Id,Name from Contact Where Name='Akash Gaikwad' OR Name='Amit singh'];
        
        list<contact> d=[select Id,Name,Account.Name,createdDate from contact order by createdDate ASC limit 10];
        
        list<Student__c> t=[select Id,Name,createdDate,CreatedById from Student__c Order by createdDate ASC limit 2];
        
        List<Account> w=[select Id , Name ,(select Id ,Name from Opportunities) from Account order by CreatedDate ASC limit 10];
        
        List<Account> Y=[select Id , Name ,(select Id ,Name from Opportunities) from Account order by CreatedDate Desc limit 10];
        
        list<Contact> j=[select Id,AccountId,Account.Phone,Account.Name from Contact limit 15];
        
        List<AggregateResult> k =[select sum(Amount) from Opportunity];
        
        list<AggregateResult> l=[select count(Id) from Contact group By AccountId]; 
        
        list<AggregateResult> G=[select avg(amount) from opportunity where stageName='closed won'];
        
        List<AggregateResult> Av=[select MAX(amount) from opportunity where stageName='Closed Lost'];
        
        
        List<AggregateResult> de=[select Min(amount) from opportunity where stageName='Perception Analysis'];
        
        List<AggregateResult> va=[select Max(amount) from opportunity where Amount <250000];
        
        system.debug(p);
        system.debug(s);
        System.debug(d);
        system.debug(t); 
        system.debug(w);
        system.debug(Y);
        system.debug(j);
        system.debug(k);
        system.debug(l);
        system.debug(G);
        system.debug(Av);
        system.debug(de);
        system.debug(va);
    }
}