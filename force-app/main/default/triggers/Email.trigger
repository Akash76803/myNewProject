trigger Email on EmailMessage (after insert) {
    
    
    if(trigger.isInsert){
        if(trigger.isAfter){
            EmailHelper.updateOppStage(trigger.newMap);
        }
    }
}