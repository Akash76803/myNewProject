public class Database_class_ex {
    public static void create_Account(){
        //create account
        Account ac = new Account();
        ac.Name = 'Apex account 5';
        ac.Active__c ='Yes';
        Database.insert (ac);
        system.debug('Account; '+ ac);
        
        //create accounts contact
        Contact con = new Contact();
        con.AccountId = ac.Id;
        con.FirstName = 'Accounts1';
        con.LastName = ac.Name;
        Database.insert (con, false);
        system.debug('Account contact; '+ con);
        
        //create accounts contacts opportunity
        Opportunity op = new Opportunity();
        op.Name = ac.Name;
        op.AccountId = ac.Id;
        op.ContactId = con.Id;
        op.CloseDate = system.today()+2;
        op.StageName = 'Value Proposition';
        Database.insert (op, false);
        system.debug('Account contact opportunity; '+ op);
        
        //create product
        Product2 pp = new Product2();
        pp.Name = 'Amul Gold Milk';
        pp.ProductCode = 'Amul112478';
        pp.CurrencyIsoCode ='USD';
        pp.IsActive = true;
        Database.insert (pp, false);
        system.debug('Account contact opportunity product; '+ pp);
        
        //create custom pricebook for premium customer.
        Pricebook2 pb = new Pricebook2();
        pb.Name = 'Premium Customer';
        pb.IsActive = true;
        pb.Description = 'This is amul premium customer pricebook';
        Database.insert (pb, false);
        system.debug('Account contact opportunity product; '+ pb);
        
        //Get standard pricebook
        Pricebook2 pb2 = [select id from Pricebook2 where isStandard = true Limit 1];
        system.debug('standard price book: ' + pb2);
        
        //Create PricebookEntry and Add standard pricebook to pricebook entry
        PricebookEntry PBE1 = new PricebookEntry();
        PBE1.Pricebook2Id = pb2.Id;
        PBE1.Product2Id = pp.Id;
        PBE1.UnitPrice = 200;
        PBE1.CurrencyIsoCode = 'USD'; 
        PBE1.UseStandardPrice = false;
        PBE1.IsActive = true;
        Database.insert (PBE1, false);
        system.debug('Account contact opportunity product; '+ PBE1);
        
        //create custom price book entry and add custom pricebook
        PricebookEntry PBE = new PricebookEntry();
        PBE.Pricebook2Id = pb.Id;
        PBE.Product2Id = pp.Id;
        PBE.UnitPrice = 180;
        PBE.CurrencyIsoCode = 'USD';
        PBE.UseStandardPrice = false;
        PBE.IsActive = true;
        Database.insert (PBE, false);
        system.debug('Account contact opportunity product; '+ PBE);
        
        /*
op.Pricebook2Id = pb.Id;
update op;
system.debug('Account contact opportunity update; '+ op);
*/
        
        //Create opportunity line item.
        OpportunityLineItem oli = new OpportunityLineItem();
        oli.Description ='Apex OLI';
        oli.Quantity = 2;
        oli.UnitPrice = 180;
        oli.Product2Id = pp.Id;
        oli.PricebookEntryId = PBE.Id;
        oli.OpportunityId = op.Id;
        Database.insert (oli, false);
        system.debug('Account contact opportunity line item inserted; '+ oli);
        
        //Upsert operation
        list<Account> acl = new list<Account>();
        for(Account a: [select id, name, Active__c, phone from Account Where name = 'Apex account 4' ]){
            a.phone = '8790644358';
        }
        For(integer i = 1; i<=10; i++){
            Account ac1 = new Account ();
            ac1.Name = 'Upsert Account' + i;
            acl.add(ac1);
        }
        System.debug('New List of Account: '+ acl);
      database.upsert(acl, false);
    }
    
}