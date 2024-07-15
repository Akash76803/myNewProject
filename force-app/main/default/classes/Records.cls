public class Records {

    public List <contact> con{get;set;}
public void search()
{
con = [SELECT LastName, Id FROM Contact LIMIT 100];
}
}