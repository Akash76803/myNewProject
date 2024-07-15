public class Account_Action_Invc_Method {
@InvocableMethod
    public static list<decimal> updateAccRevenue(List<id> ids){
        List<Opportunity> opplist = [select AccountId, amount from Opportunity where id =: ids[0]];
        list<Account> AccList = [select id, AnnualRevenue from Account where id =: opplist[0].AccountId];
        system.debug(Acclist);
        List<Decimal> annualRevenueList = new List<Decimal>();
        if(AccList[0].AnnualRevenue != null){
        AccList[0].AnnualRevenue =  AccList[0].AnnualRevenue + opplist[0].amount;
       annualRevenueList.add(AccList[0].AnnualRevenue);
        }else(system.debug('Error'));
        update AccList;        
        return annualRevenueList;
    }
}