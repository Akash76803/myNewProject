trigger oppWonStageTrigger on Opportunity (after update) {

    oppWonStageTriggerHelper.sendEmailToAccOwner(trigger.new, trigger.oldmap);
}