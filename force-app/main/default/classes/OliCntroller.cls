public class OliCntroller {
 @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem> findOliByOpportunityId(String opportunityId) {      
        return [
            SELECT Id, Name, Product2Id, ProductCode, Quantity, UnitPrice, Subtotal, TotalPrice, OpportunityId	
            FROM OpportunityLineItem 
            WHERE OpportunityId=:opportunityId 

            LIMIT 10];
    }
}