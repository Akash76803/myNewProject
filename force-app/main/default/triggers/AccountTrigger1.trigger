trigger AccountTrigger1 on Account (after update) {
    list<contact> clist = new list <contact>();
    for(Contact c: [select id, name, accountId, homephone from contact where accountId in: trigger.new]){
        for(Account a: trigger.new){
            if(a.id == c.AccountId){
                c.HomePhone = a.Phone;
                clist.add(c);
            }
        }
    }
    update clist;
}