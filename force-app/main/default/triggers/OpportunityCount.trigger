trigger OpportunityCount on Opportunity (before insert, after insert, before update, after update, before delete, after delete, after undelete) {

    if(trigger.isInsert && trigger.isAfter){
        OpportunityCountHelper.countOpportunityAfterInsert(trigger.new);
    }
     if(trigger.isUpdate && trigger.isAfter){
        OpportunityCountHelper.countOpportunityAfterUpdate(trigger.new, trigger.oldMap);
    }
    //countOpportunityBeforerDelete
    if(trigger.isDelete && trigger.isBefore){
        OpportunityCountHelper.countOpportunityBeforerDelete(trigger.old, trigger.oldMap);
    }
     if(trigger.isDelete && trigger.isAfter){
        OpportunityCountHelper.countOpportunityAfterDelete(trigger.old, trigger.oldMap);
    }
    if(trigger.isUndelete && trigger.isAfter){
        OpportunityCountHelper.countOpportunityAfterUnDelete(trigger.new, trigger.newMap);
    }
}