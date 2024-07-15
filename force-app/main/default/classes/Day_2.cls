public class Day_2 {

    //find greater number

public static integer bignum(integer x, integer y){
    integer a = x;
    integer b = y;
    if(a>b){
        System.debug('A is bigger number: '+a);
        return a;
    }
    if(b>a){
     System.debug('B is bigger number: '+b);   
    }
    return b; 
}
    public static Decimal degree_to_Fahrenheit(Decimal num){
        Decimal num1 = num;
        Decimal result = (num1 * 1.8)+ 32;
        System.debug('Your Degree celcious to Fahrenheit: '+result);   
        return result;
    }
    public static Decimal Fahrenheit_to_degree(Integer nums){
        Integer num1 = nums;
        System.debug('Your Fahrenheit to Degree celcious : '+num1); 
        Decimal result = (num1 - 32)*(.5556);
        System.debug('Your Fahrenheit to Degree celcious : '+result);   
        return result;
    }
  
}