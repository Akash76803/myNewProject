trigger UpdateAccContact on Account (after update, before update) {
if(trigger.isUpdate && trigger.isAfter){
UpdateAccContactHelper.deleteContact(trigger.newMap);
}

if(trigger.isUpdate && trigger.isBefore){
UpdateAccContactHelper.getOpportunityAmount(trigger.new);
}
}