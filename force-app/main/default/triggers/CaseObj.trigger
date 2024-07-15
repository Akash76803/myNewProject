trigger CaseObj on Case (before insert) {
//When ever a case is created with origin as email then set status as new and Priority as Medium.

    if(trigger.isInsert){
        if(trigger.isBefore){
            CaseObj_Handler.caseOrigin(trigger.new);
        }
        if(trigger.isAfter){
            
        }
    }
}