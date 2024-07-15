trigger ContactFuture on Contact (after insert) {
    if(trigger.isInsert){
        if (trigger.isAfter){
            list<id> ids = new list<id>();
            for(Contact c: trigger.new){
                ids.add(c.Id);
                ContactFutureHelper.doPost(ids);
                System.debug('Contact Id: '+ ids);
            }
        }
    }
    
}