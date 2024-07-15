public class ContactMultiSelectLookupController {

//Task object data inserted  here
@AuraEnabled
    public static void savecontactData(Contact contactData){
        if(contactData != NULL){
            insert contactData;
            System.debug(contactData);
        }
        System.debug('Saves Data'+contactData);
}
//Task object data inserted  here
@AuraEnabled
    public static void saveTaskData(Task taskData){
        if(taskData != NULL){
            insert taskData;
            System.debug(taskData);
        }
        System.debug('Saves Data'+taskData);
}


//objects object multi - picklist getting here
 @AuraEnabled(cacheable=true)
    public static map<string, object> getInitialData(){
        Map<string, object> returnMap = new Map<string, object>();
        returnMap.put('phoneOptions',CommonUtil.getLightningPickListValues('Preferred_Phone__c','Contact'));
        returnMap.put('languageOptions',CommonUtil.getLightningPickListValues('Select_Language__c','Contact'));
        returnMap.put('SubjectOptions',CommonUtil.getLightningPickListValues('Subject','Task'));
        returnMap.put('PriorityOptions',CommonUtil.getLightningPickListValues('Priority','Task'));
        returnMap.put('StatusOptions',CommonUtil.getLightningPickListValues('Status','Task'));
       returnMap.put('languageSelectOptions',CommonUtil.getLightningPickListValues('Select_Language__c','Task'));
        returnMap.put('PicklistAOptions',CommonUtil.getLightningPickListValues('Picklist_A__c','Task'));
         returnMap.put('PicklistBOptions',CommonUtil.getLightningPickListValues('Picklist_B__c','Task'));

        return returnMap;
    }
    //multi lookup start here
   @AuraEnabled(cacheable=true)
    public static List<sObject> retriveSearchData(String ObjectName, String fieldName, String value, List<String> selectedRecId, string accoid) {
        System.debug('retriveSearchData '+ accoid);
        List<sObject> sObjectResultList = new List<sObject>();
        if(selectedRecId == null)
            selectedRecId = new List<String>();
        if(String.isNotEmpty(value)) {
            String query = 'Select '+fieldName+' ' + ' FROM '+ObjectName+' WHERE Name LIKE \'%' + value.trim() + '%\' and ID NOT IN: selectedRecId and accountId =: accoid order by createdDate';  
            for(sObject so : Database.Query(query)) {
                sObjectResultList.add(so);
            }
        }
        return sObjectResultList;
    
    }
//contack object picklist getting here
      @AuraEnabled(cacheable=true)
    public static List<String> getPrefferedPhonePicklistValues() {
        List<String> picklistValues = new List<String>();
        
        Schema.DescribeFieldResult fieldResult = Contact.Preferred_Phone__c.getDescribe();
        List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
        
        for (Schema.PicklistEntry entry : picklistEntries) {
            picklistValues.add(entry.getLabel());
        }
        
        return picklistValues;
    }
  
    //saving task data here.
  @AuraEnabled
  public static void savetask(object obj){
      System.debug('Data Recived'+ obj);
      Map<String, Object> taskMap = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(obj));
      taskMap.remove('WhoId');
      System.debug('Data Recived'+ obj);
       Map<String, Object> dataMap = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(obj));
       System.debug('Data map'+ dataMap.get('WhoId'));

       List<Contact> conlist = (List<Contact>)JSON.deserialize(JSON.serialize(dataMap.get('WhoId')), List<Contact>.class);
		 System.debug('Data conlist'+ conlist);
       Task tk = (Task)JSON.deserialize(JSON.serialize(taskMap), Task.class);
       System.debug('Task: '+tk);
       insert tk;
	 List<TaskRelation> taskLsit = new List<TaskRelation>();
    for(Contact cons: conlist){			
           TaskRelation tskr = new TaskRelation();
            tskr.TaskId = tk.id;
            tskr.RelationId = cons.id;
           taskLsit.add(tskr);
       }
      if(taskLsit.size()>0){
          insert taskLsit;
          system.debug(taskLsit);
      }
  }
	 //Display the Contacts based on AccountId the help of event in LWc
    @AuraEnabled(cacheable=true)
    public static List<Account> retrieveAccountRecords(){
        List<Account> accList = [Select Id, Name, CreatedDate From Account ORDER BY CreatedDate limit 20];
        return accList;
    }
 
 
    @AuraEnabled(cacheable=true)
    public static List<Contact> retrieveContactRecords(string accId){
      List<Contact> conObj = new  List<Contact>();
      List<Contact> conList = [Select Id, FirstName, LastName, AccountId From Contact Where AccountId=:accId];
      for(Contact con:conList){
        conObj.add(con);
      }
      return conObj;
    }

    //datatable contact
    @AuraEnabled(Cacheable = true)
    public static List<Contact> getContacts() {
        return [SELECT Id, Name, FirstName, LastName, Phone, Email , Select_Language__c
                FROM Contact 
                ORDER BY CreatedDate limit 20];
    }
}