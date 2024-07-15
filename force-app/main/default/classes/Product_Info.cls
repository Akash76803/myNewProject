public class Product_Info {
    public string prodName;
    public integer quantity;
    public decimal price;
    public Product_Info(string name,integer quant, decimal cost){
        prodName= name;
        quantity = quant;
        price = cost;
    }
    public void show(){
        system.debug('Name: '+ prodName);
        system.debug('quantity: '+ quantity);
        system.debug('price: '+ price);
/*EXECUTION:
Product_Info obj = new Product_Info('Ponds', 40, 40*36);
obj.show();


*/
        

    }
}