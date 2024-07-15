trigger OpportunityTrigger on Opportunity (before insert, after insert, after update, before update) {
   TriggerDispatcher.run(new OpportunityHandler(), 'OpportunityTrigger');

}