public class createAcc {

    public account createAccount(string name){
        account ac = new account();
        ac.Name = name;
        system.debug(ac.Name);
        return ac;
    }
}