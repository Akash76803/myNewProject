public class oppWonStageTriggerHelper {
    
    public static void sendEmailToAccOwner(list<opportunity>oplist, map<id, opportunity> oldmap){
        set<id> ownerIds = new set<id>(); 
        set<id> acOwnerIds = new set<id>(); 
        
        for(opportunity op: oplist){
            opportunity opps= oldmap.get(op.id);
            if(op.AccountId!= null && op.StageName == 'closed won' && op.Amount >= 10000 && op.StageName != opps.StageName){
                acOwnerIds.add(op.AccountId);
            }
            for(Account ac: [select id, name, ownerId from Account where id in: acOwnerIds]){
                ownerIds.add(ac.OwnerId);
            }
        }
        system.debug('ownerIds: '+ ownerIds);
        list<user> us = [select id, name, email from user where id in:ownerIds];
        system.debug('user: '+ us);
        list<string> email = new list<string>();
        for(user u :us ){
            email.add(u.Email);
        }
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        // String[] sendingTo = new String[]{sendemail};
        semail.setToAddresses(email);
        semail.setSubject('Single Email message Example'); 
        semail.setPlainTextBody('Hello!!!!!!!!!!This is a test email to test single email message program');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
        
    }
}