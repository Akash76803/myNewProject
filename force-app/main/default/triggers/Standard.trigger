trigger Standard on Standard__c (before delete, after delete) {
if(trigger.isBefore && trigger.isDelete){
StandardTriggerHelper.beforeDelete(trigger.oldmap);
}
}