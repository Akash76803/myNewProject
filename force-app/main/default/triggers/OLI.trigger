trigger OLI on OpportunityLineItem (after Insert) {

    TriggerDispatcher.run(new OpportunityLineItem_Handler(), 'OLITrigger');
}//OLITrigger