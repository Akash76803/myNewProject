public class SOQL_COUNT_EXAMPLE {
    public list<Account>acc{set;get;}
    public SOQL_COUNT_EXAMPLE(){
        acc =[select id, name,phone, industry from Account];
    }
    public  void limit5(){
        acc =[select id, name,phone, industry from Account limit 5];
    }
    public void count(){
      integer  counts = 3;
        acc =[select id, name,phone, industry from Account limit: counts];
    }
    public void offset5(){
         acc =[select id, name,phone, industry from Account offset 5];
    }
    public void offstcount5(){
        integer count = 10;
         acc =[select id, name,phone, industry from Account offset : count];
 
    }
     public void offsetlimit(){
        
         acc =[select id, name,phone, industry from Account limit 3 offset 5 ];
 
    }
}