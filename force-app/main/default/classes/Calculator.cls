public class Calculator {
@AuraEnabled
    public static list<integer> calculate(Integer num1, integer num2){
        
        List<Integer> numbers = new list<Integer>();
        integer result = num1 + num2;
        numbers.add(num1);
         numbers.add(num2);
        numbers.add(result);
        system.debug(numbers);
        
        return numbers;
    }
}