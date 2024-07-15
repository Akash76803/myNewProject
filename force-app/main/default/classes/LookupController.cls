public class LookupController {
    
    @AuraEnabled(cacheable = false)
    public static List <SearchResult> searchRecords(SearchRequest request) 
    {
        system.debug('request:'+request);
        List<SearchResult> sObjectResultList = new List<SearchResult> ();
        List<String> selectedRecIds=request.selectedRecIds;
        if (selectedRecIds == null)
        {
            selectedRecIds = new List<String>();
        }
        string fieldstoQuery=request.titleFieldName+(string.isNotBlank(request.subTitleFieldName)?','+request.subTitleFieldName:'');
        if(string.isNotBlank(request.subTitleFieldName) && string.isNotBlank(request.subTitle2FieldName))
        {
            fieldstoQuery=fieldstoQuery+','+request.subTitle2FieldName;
        }
        system.debug('fieldstoQuery:'+fieldstoQuery);
        if (String.isNotBlank(request.objectName) && String.isNotBlank(fieldstoQuery)) {
            
            string queryStr = 'SELECT ' + String.escapeSingleQuotes(fieldstoQuery) + '' + ' FROM ' + String.escapeSingleQuotes(request.objectName) + ' WHERE Id != null';
            
            if (String.isNotBlank(request.searchKey)) {
                String key = '%' + String.escapeSingleQuotes(request.searchKey) + '%';
                string displayName = String.escapeSingleQuotes(request.titleFieldName);
                queryStr += ' AND ' + displayName + '  LIKE :key';
            }
            
            if (String.isNotBlank(request.queryCondition)) {queryStr += ' AND ' + String.escapeSingleQuotes(request.queryCondition);}
            if (selectedRecIds != null) {queryStr += ' AND ID NOT IN: selectedRecIds';}
            
            List <sObject> sObjectList = Database.Query(queryStr.replace('\\\'', '\''));
            system.debug('sObjectList:'+sObjectList);
            for (sObject so: sObjectList) {
                String fieldvalue = (String) so.get(request.titleFieldName);
                if (String.isNotBlank(fieldvalue)) {
                    sObjectResultList.add(new SearchResult(so.Id,fieldvalue, so));
                }
            }
        }
        system.debug('sObjectResultList:'+sObjectResultList);
        return sObjectResultList;
    }
    
    @AuraEnabled(cacheable = true)
    public static List<SearchResult>  getRecordsByIds(SearchRequest request) {
        List<SearchResult> sObjectResultList = new List <SearchResult > ();
        List<String> selectedRecIds=request.selectedRecIds;
        if (selectedRecIds == null)
        {
            selectedRecIds = new List<String>();
        }
        string fieldstoQuery=request.titleFieldName+(string.isNotBlank(request.subTitleFieldName)?','+request.subTitleFieldName:'');
        if(string.isNotBlank(request.subTitleFieldName) && string.isNotBlank(request.subTitle2FieldName))
        {
            fieldstoQuery=fieldstoQuery+','+request.subTitle2FieldName;
        }
        
        string queryStr = 'SELECT ' + String.escapeSingleQuotes(fieldstoQuery) + '' + ' FROM ' + String.escapeSingleQuotes(request.objectName) + ' WHERE Id in : selectedRecIds';
        system.debug('queryStr:'+queryStr);
        List <sObject> sObjectList = Database.Query(queryStr.replace('\\\'', '\''));
        for (sObject so: sObjectList) {
            String fieldvalue = (String) so.get(request.titleFieldName);
            if (String.isNotBlank(fieldvalue)) {
                sObjectResultList.add(new SearchResult(so.Id,fieldvalue, so));
            }
        }
        system.debug('sObjectResultList:'+sObjectResultList);
        return sObjectResultList;
    }
    
    Public class SearchRequest{
        @AuraEnabled
        public string searchKey{get;set;}
        @AuraEnabled
        public string objectName{get;set;}
        @AuraEnabled
        public string titleFieldName{get;set;} 
        @AuraEnabled
        public string subTitleFieldName{get;set;} 
        @AuraEnabled
        public string subTitle2FieldName{get;set;} 
        @AuraEnabled
        public string queryCondition{get;set;} 
        @AuraEnabled
        public List<String> selectedRecIds{get;set;}
    }
    
    public class SearchResult
    {
        @AuraEnabled
        public sObject record;
        @AuraEnabled
        public String recordId;
        @AuraEnabled
        public String recordName;
        public SearchResult(string recId, string recName, sObject rec)
        {
            recordId=recId;
            recordName=recName;
            record=rec;
        }
    }
}