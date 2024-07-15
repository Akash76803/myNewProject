public class HelloWorld {
    public static void newMethod(){
        integer x, y;
        x = 23;
        y= 45;
        Integer sum = x + y;
        system.debug('Result: '+ sum);
        
    }
    
    public void newMethod1(integer x, integer y){
        
        Integer sum = x + y;
        system.debug('Result: '+ sum);
        
        list<string> lit = new list<string>();
        lit.add('a');
        lit.add('b');
        lit.add('f');
        lit.add('d');
        lit.sort();
         system.debug('Result: '+ lit);
    }
    public static void howToUseSet(){
         set<string> lit = new set<string>();
        lit.add('a');
        lit.add('b');
        lit.add('c');
        lit.add('d');
        lit.add('d');
        lit.add('e');
        lit.add('f');
        
         system.debug('Result: '+ lit);
        
    }

}