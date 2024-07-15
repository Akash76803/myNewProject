public class Wipro_Employee {

    public string companyName;
    public string city;   
    public decimal bonus, exp, Salary;
  
    public Wipro_Employee(decimal experience){
        companyName= 'Wipro';
        city = 'Hyd';
        exp = experience;
    }
    public void setData(){
        if( exp > 5){
          Salary = 50000;
            bonus = 5000;
            
        }else
            if(exp <= 5){
            Salary= 30000;
            bonus = 3000;
        }
    }
    
    public void show(){
        /*Wipro_Employee obj = new Wipro_Employee(5);
        system.debug(obj.bonus);
        system.debug(obj.city);
        system.debug(obj.companyName);
        system.debug(obj.exp);
        system.debug(obj.Salary);*/
        
      system.debug(Salary);
        system.debug(companyName);
        system.debug(city);
        system.debug(bonus);
        system.debug(exp);
        
    }
}