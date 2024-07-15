trigger contact_Trigger on Contact ( before delete, after delete, before insert, after insert, before update, after update ) {
    if(Trigger.isInsert){
        if(trigger.isBefore){
            
        }
        if(trigger.isAfter){
           
     /*      if(!StopRecurssion.isStop ){
                StopRecurssion.isStop = true;
                contact_Trigger_Handler.CloneAfterInsertAccounts(trigger.new);
            }
            if(!Is_Stop.isStop ){
                Is_Stop.isStop = true;
                contact_Trigger_Handler.getAccount(trigger.new);
            }*/ 
          
        }
    }
    if(Trigger.isUpdate){
        if(trigger.isBefore){
            ContactTriggerHandler.updatePrimaryCheckbox(trigger.new, trigger.newMap, trigger.oldMap);
        }
         if(trigger.isAfter){
          ContactTriggerHandler.updateAccDescription(trigger.newMap);
        }
    }
    
     if(Trigger.isDelete){
        if(trigger.isBefore){
            ContactTriggerHandler.updateConId(trigger.old);
        }
         if(trigger.isAfter){
        //   ContactTriggerHandler.updatePrimaryContact(trigger.old);
        }
    }
}