public class LwcController3 {
@AuraEnabled

    public static void savecontactData(Contact contactData){

        if(contactData != NULL){

            insert contactData;

        }
}
    @AuraEnabled(cacheable=true)
    public static map<string, object> getInitialData(){
        Map<string, object> returnMap = new Map<string, object>();
        returnMap.put('languageOptions',CommonUtil.getLightningPickListValues('Select_Language__c','Contact'));
        return returnMap;
    }
}