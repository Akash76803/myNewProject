trigger contacttrig on Contact (before insert) {

    set<id> ids = new set<id>();
    for(contact c: trigger.new){
        ids.add(c.AccountId);
    }
    
    //BEFORE INSRET
    if(trigger.isBefore && trigger.isInsert ){
        for(Contact c: trigger.new){
            string var = c.Phone;
            string countryCode;
            
            if( string.isBlank(c.phone) || c.Phone.length() <= 0 || c.phone.length()<13 || c.phone.length()>14   ){
                c.addError('Please sure length of phone is not less or greater than 13 number with include country code.');
            }
            
            if(c.Country__c == 'India' && c.Phone != null && !var.startswith ('+91') ){
                c.addError('Please put valid country code');
            }
            
            if(c.Country__c == 'Pakistan' && c.Phone != null && !var.startswith('+92')){
                c.addError('Please put valid country code');
            }
            
            if(c.Country__c == 'Dubai' && c.Phone != null && !var.startswith('+12') ){
                c.addError('Please put valid country code');
                
            }
            
            
            
        }
        //LIMIT EXCEED
        decimal counter ;
        integer listsize;
        for(Account ac: [select id, name, Accounts_Contact_Limit__c,(select id, name, AccountId from contacts) from account where id in : ids]){
            system.debug('size of contact: '+ ac);
            counter = ac.Accounts_Contact_Limit__c;
            listsize = ac.contacts.size();
        }
        system.debug('size of contact: '+ listsize);
        system.debug('size of Accounts_Contact_Limit: '+ counter);
        for(contact ct: trigger.new){
            if((listsize+1) > counter ){
                ct.addError('Limit Exceed');
            }
        }
        //SEQUENCE OF CONTACT 
        integer size;
        for(Account ac: [select id, name, Accounts_Contact_Limit__c,(select id, name, AccountId from contacts) from account where id in : ids]){
            size = ac.contacts.size();
        }
        for(contact c: trigger.new){
            c.Contact_Sequence__c = size +1;
        }
        
    }
    //BEFORE UPDATE
    if(trigger.isBefore && trigger.isUpdate){
      /*
       * for(Contact c: trigger.new){
            string var = c.HomePhone;
             if(c.Country__c  == null ){
                    c.addError('Please check country is not null');
                }
                if(  c.HomePhone.length()!=13    ){
                    c.addError('Please sure length of phone is not less or greater than 10 number with include country code Before Starting Phone Number.');
                }
                if(  c.Country__c == 'India' && c.HomePhone == null){
                    c.addError('Please insert phone number');
                }
                if(  c.Country__c == 'India' && !var.startswith('+91') && c.HomePhone.length()!=13 ){
                    c.addError('Please put valid country code for your country '+ c.Country__c);
                }
                if(c.Country__c == 'Pakistan' && c.HomePhone != null && !var.startswith('+92') ){
                    c.addError('Please put valid country code for your country '+ c.Country__c);
                }
                
                if(c.Country__c == 'Dubai' && c.HomePhone != null && !var.startswith('+01') ){
                    c.addError('Please put valid country code for your country '+ c.Country__c);
                    
                } 
}
*/  
        
        
        
        //SEQUENCE OF CONTACT IN THIS SCENARIO WHEN CONTACTs ACCOUNT IS UPDATE ON CONTACT ITS SEQUENCE ALSO UPDATE
        map<id, list<contact>> acmpap = new map <id, list<contact>> ();
        integer size;
        system.debug('Ids: '+ ids);
        for(Account ac: [select id, name, Accounts_Contact_Limit__c,(select id, name, AccountId from contacts ) from account where id in : ids]){
            system.debug('AC: '+ ac); 
            acmpap.put(ac.id, ac.contacts);
            system.debug('ACmap: '+ acmpap);
        }
        system.debug('acmpap: '+ acmpap);
        
      
            for(contact c: trigger.new){
                system.debug(''+ trigger.oldMap.get(c.Id).AccountId);
                
                if(c.AccountId != trigger.oldMap.get(c.Id).AccountId && acmpap.containsKey(c.accountId) ){
                    size = acmpap.get(c.AccountId).size()+1 ;
                    c.Contact_Sequence__c = size;
                    system.debug('Size: '+ size);
                    system.debug('Contact_Sequence: '+ c.Contact_Sequence__c);
                }
            }
        
    }
    //======================COPY ADDRESS FROM ACCOUNT===========
    map<id, account> acmap = new map<id, account>([select id, name, phone, ShippingCity, ShippingCountry, ShippingState from account where id in :ids]);
    for(Contact cons: trigger.new){
        if(cons.Copy_Address__c == true){
            cons.MailingCity = acmap.get(cons.AccountId).ShippingCity;
            cons.MailingCountry = acmap.get(cons.AccountId).ShippingCountry;
            cons.MailingState = acmap.get(cons.AccountId).ShippingState;
        }
    }
    
    list<account> aclist = [select id, name, phone from account where id in: ids];
    for(account ac: aclist){
        for(contact con: trigger.new){
            if(con.Phone!= null){
                con.Phone = ac.phone;
            } 
        }
    }
    
    //=======BEFORE INSERT============

    
}
//map<id, account> acmap = new map<id, account>([select id, name, phone from account where id in :ids])
//for(contact c: trigger.new){
//c.phone = acmap.get(c.accountId).phone;
//}
//
//map<id, account> acmap = [select id, name, active from account where id in : trigger.new]
//
//<<--------SCENARIO------>>
//CHECH BOX FIELD ON CONTACT 
//COPY ADDRESS CHECK BOX IN CONTACT TRUE COPY ADDRESS FROM ACCOUNT PASTE IN CONTACT.
//
//COUNTRY && PHONE CODE VALIDATION.
//