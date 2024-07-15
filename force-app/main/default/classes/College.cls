public class College {
    string name;
    string phone;
    string city;
    
    public College(){
        name= 'CBIT';
        phone = '9890164660';
        city = 'Pune';
    }
    public void show(){
        System.debug('Name: '+ name);
         System.debug('Phone: '+ phone);
         System.debug('City: '+ city);
    }
}