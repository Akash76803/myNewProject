public class FutureMethodExample {
    //create user, profile, account record 
 /*
public static void createAccRec(){
        Account a = new Account();
        a.Name = 'Future Account';
        insert a;
    }
*/   
    
    public static void createUser(){
        Profile p = [select id, name from profile where name  = 'SFDC 1' limit 1 ];
        Account a = new Account();
        a.Name = 'Future Account New';
        a.Active__c = 'yes';
        insert a;
        
        User u = new User();
        if(a.Active__c == 'yes'){
             u.FirstName = a.Name;
        u.LastName = 'Method';
        u.Alias =u.FirstName.LEFT (1) +u.LastName.RIGHT (4) ;
        u.Email= 'akash@plus91labs.com';
        u.Username = 'abcd@123.com.test';
        u.CommunityNickname = 'USER123456567890';
        u.ProfileID = p.Id;
        u.LocaleSidKey = 'en_US';
        u.TimeZoneSidKey = 'GMT';
        u.LanguageLocaleKey = 'en_US';
        u.EmailEncodingKey = 'UTF-8';
        system.debug(u);
       
        }
        insert u;
        //  u.UserRoleId = '00E2w000000iwvkEAA';
       
    }
    
}