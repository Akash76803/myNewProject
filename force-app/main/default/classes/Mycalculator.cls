public class Mycalculator {

  static string[] one_to_19 = new string [] {'zero', 'One',  'Two', 'Three', 'Four',  'Five',  'Six', 'Seven',
                                              'Eight', 'Nine', 'Ten',  'Eleven', 'Twelve', 'Thirteen',  
                                              'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'
        									};
	List<string> tens = new list<string> { 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'};
        
        List<string> thousand = new list<string>{'',
                                             'Thousand',   'Million',     'Billion',    'trillion',    'quadrillion',  
                                             'quintillion', 's!xtillion',   'septillion',  'octillion',   'nonillion',  
                                             'decillion',  'undecillion',   'duodecillion', 'tredecillion',  'quattuordecillion',  
                                             'sixdecillion', 'septendecillion', 'octodecillion', 'novemdecillion', 'vigintillion'};
                                                 
	public static string convert_nn(integer val) {
        if (val < 20){
            return one_to_19[val];
        }
        
        return 'Should never get here, less than 100 failure';
    }
}