trigger OLItest on OpportunityLineItem (before insert, before update, after insert, after update) {
/*
if(trigger.isInsert && trigger.isBefore){
OLItestHelper.restricToInsertOLI(trigger.new);
}
*/

if(trigger.isInsert && trigger.isAfter){
OLItestHelper.afterInsertUpdateAccount( trigger.newMap);
}

}