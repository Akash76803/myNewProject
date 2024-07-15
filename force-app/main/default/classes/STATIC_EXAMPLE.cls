public class STATIC_EXAMPLE {
 public integer Avalue= 0;
    public static integer Bvalue = 0;
    public void show(){
        Avalue = Avalue+10;
        Bvalue = Bvalue+10;
        system.debug( 'a: '+ Avalue);
        system.debug('b: ' + Bvalue);
        
    }
}