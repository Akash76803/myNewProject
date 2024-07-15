public class SOQL_EXAMPLE {
    public list<Account> accounts{set;get;}
    public list<Contact> contacts{set;get;}
    public SOQL_EXAMPLE(){
        accounts=[select id, name,phone, industry from Account];
        contacts = [select id, name, Phone, OtherPhone from Contact ];
    } 
    
    
}