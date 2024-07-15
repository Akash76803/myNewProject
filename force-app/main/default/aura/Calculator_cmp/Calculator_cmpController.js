({
	handleClick1 : function(component, event, helper) {
        let val= event.getSource().get('v.value');
		let number1 = parseInt(component.get('v.Num1')) ;
        let number2 = parseInt(component.get('v.Num2'));
        
        let number3 = parseInt(component.get('v.Num1')) ;
        let number4 = parseInt(component.get('v.Num2'));
        let resultnew = component.get('v.result');
        var results;
        var results1;
        
        if( val === 'Add')
        {
         results =  number1 + number2;
        }else if( val === 'Sub')
        {
        results= number1 - number2;     
        }else if( val === 'Div')
        {
         results = number1 / number2 ;  
        }else if( val === 'Mult')
        {
         results = number1 * number2;
        }
     	component.set('v.result', results); 
       if( results !== null)
        {
            
            number2 = component.set('v.Num2', 0);
        }
         if( number3 === null )
        {
            number3 = parseInt(component.get('v.Num1'));
           number4 = parseInt(component.get('v.Num2'));
           results1 = resultnew + number3;
            if(val='Add'&& number3 !== null){
                number3 = parseInt(component.get('v.Num1'));
           number4 = parseInt(component.get('v.Num2'));
           results1 = resultnew + number3;
         
            }
            component.set('v.result', results1); 
            
        }
    }
})