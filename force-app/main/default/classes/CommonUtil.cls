public class CommonUtil {

    public static string getAllFields(String objectAPIName){
        string returnString;
        try {
            System.debug('REQUEST : '+objectAPIName);
            list<string> apiNames = new List<string>();
            Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectAPIName.trim()).getDescribe().fields.getMap();
            for(string obj : objectFields.keySet()){
                apiNames.add(obj);
            }
            returnString = string.join(apiNames,',');
        } catch (Exception e) {
            System.debug('error in get all field class : '+e.getMessage()+' at line no : '+e.getLineNumber());
            returnString = '';
        }
        
        return returnString;
    }

    public static list<String> getPickListValues(String fieldName, string objectName){
        list<String> returnList = new list<String>();
        System.debug('Object : '+objectName+' : Field name : '+fieldName);
        try {
            Map<String, schema.SObjectField> feildMap = Schema.getGlobalDescribe().get(objectName.trim()).getDescribe().fields.getMap();
            list<Schema.PicklistEntry> values = feildMap.get(fieldName.trim()).getDescribe().getPickListValues();
            for (Schema.PicklistEntry obj : values) {
                returnList.add(obj.getValue().remove('\'').escapeUnicode());
            }
            returnList.sort();
            System.debug('MAP with FEILD TYPE : '+returnList);
        } catch (Exception e) {
            System.debug('error in datafetching method : '+e.getMessage()+' at line no : '+e.getLineNumber());
        }
        if (returnList.isEmpty()) {
            return null;
        }else {
            return returnList;
        }
    }

    public static list<Map<string, object>> getLightningPickListValues(String fieldName, string objectName){
        list<Map<string, object>> returnList = new list<Map<string, object>>();
        System.debug('Object : '+objectName+' : Field name : '+fieldName);
        try {
            Map<String, schema.SObjectField> feildMap = Schema.getGlobalDescribe().get(objectName.trim()).getDescribe().fields.getMap();
            list<Schema.PicklistEntry> values = feildMap.get(fieldName.trim()).getDescribe().getPickListValues();
            for (Schema.PicklistEntry obj : values) {
                returnList.add(new Map<string, object>{'label'=>obj.getValue().remove('\'').escapeUnicode(), 'value'=>obj.getValue().remove('\'').escapeUnicode()});
            }
            //returnList.sort();
            System.debug('MAP with FEILD TYPE : '+returnList);
        } catch (Exception e) {
            System.debug('error in datafetching method : '+e.getMessage()+' at line no : '+e.getLineNumber());
        }
        if (returnList.isEmpty()) {
            return null;
        }else {
            return returnList;
        }
    }

    public static list<SObject> getSobjectData(string type){
        string fields = getAllFields(type);
        if (String.isNotBlank(fields)) {
            list<SObject> returnObject = Database.query('select '+fields+' from '+type);
            return returnObject;
        }else {
            return null;
        }
    }
    
    public static String getNamespacePrefix(String className, String objective) {
        String namespace = '';
        if (objective == 'Class') {
            try {
                ApexClass ac = [SELECT NameSpacePrefix FROM ApexClass WHERE Name =: className];
                if(null != ac.NameSpacePrefix) {
                    namespace = ac.NameSpacePrefix + '__';
                }
            } catch (QueryException ex) {
                System.debug('error in Apex class name : '+ex.getMessage());
            }
        }else {
            try {
                Integer indexOfToken = -1;
                for ( Schema.SObjectType type : Schema.getGlobalDescribe().values() ) {
                    String sobjName = String.valueOf(type);

                    if (null != sobjName) {
                        indexOfToken = sobjName.indexOf(className);
                    }

                    if (indexOfToken != -1) {
                        namespace = sobjName.substring(0, indexOfToken);
                        break;
                    }
                }
            } catch (Exception e) {
                System.debug('SOBJECT error : '+e.getMessage());
            }
            
        }
        
        return namespace;
    }

    public static String getFieldType(string fieldName,String objectName){
        Map<String, schema.SObjectField> feildMap = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        Schema.SObjectField field = feildMap.get(fieldName);
        Schema.DisplayType dataType = field.getDescribe().getType();
        System.debug('Field Request : '+fieldName+' type : '+dataType);
        return String.valueOf(dataType);
    }

    @AuraEnabled(cacheable=true)
    public static list<sObject> fetchLookupData(string searchKey , string sObjectApiName) {    
        List < sObject > returnList = new List < sObject > ();
        string sWildCardText = '%' + searchKey + '%';
        string sQuery = 'Select Id,Name From ' + sObjectApiName + ' Where Name Like : sWildCardText order by createdDate DESC LIMIT 5';
        for (sObject obj: database.query(sQuery)) {
            returnList.add(obj);
        }
        return returnList;
    }
    
    // Method to fetch lookup default value 
    @AuraEnabled
    public static sObject fetchDefaultRecord(string recordId , string sObjectApiName) {
        string sRecId = recordId;    
        string sQuery = 'Select Id,Name From ' + sObjectApiName + ' Where Id = : sRecId LIMIT 1';
        for (sObject obj: database.query(sQuery)) {
            return obj;
        }
        return null;
    }
}