trigger OpportunityTest on Opportunity (before update, after update) {
/*
if(trigger.isBefore && trigger.isUpdate){
OpportunityTestHelper.test(trigger.new);
}
*/
if(trigger.isAfter&& trigger.isUpdate){
OpportunityTestHelper.updateStage(trigger.newmap, trigger.oldMap);
}
}