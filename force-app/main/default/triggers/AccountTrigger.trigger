trigger AccountTrigger on Account (before insert, after update, after insert, before update) {
if(trigger.isInsert){
if(trigger.isBefore){

}
if(trigger.isAfter){
AccountTrigger_handler.AfterInsertAccount(trigger.new);
}
}
if(trigger.isUpdate){
if(trigger.isBefore){
  AccountTrigger_handler.updateType(trigger.newMap);
}
if(trigger.isAfter){
// AccountTrigger_handler.afterUpdateAccount(trigger.new);
  AccountTrigger_handler.createUser(trigger.new);
        AccountTrigger_handler.sendNotification(trigger.new);

}
   
}
if(trigger.isDelete){
if(trigger.isBefore){

}
if(trigger.isAfter){

}
}

}