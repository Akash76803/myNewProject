trigger AccountFututre on Account (after insert) {

    if(trigger.isInsert && trigger.isAfter){
        list<id> ids = new list<id>();
        for(Account ac: trigger.new){
            ids.add(ac.Id);
        }
        AccountWebserviceEx.acc(ids);
    }
}