public with sharing class PicklistValuesController {
    @AuraEnabled(cacheable=true)
    public static List<String> getIndustryPicklistValues() {
        List<String> picklistValues = new List<String>();
        
        Schema.DescribeFieldResult fieldResult = Contact.Preferred_Phone__c.getDescribe();
        List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
        
        for (Schema.PicklistEntry entry : picklistEntries) {
            picklistValues.add(entry.getLabel());
        }
        
        return picklistValues;
    }
}