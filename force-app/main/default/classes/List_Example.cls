public class List_Example {
    
    @AuraEnabled
    public static List<String> getFruitOptions(id ids) {
        return new List<String>{'Apple', 'Banana', 'Orange', 'Pineapple'};
    }
}