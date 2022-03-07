@isTest
public class AccountCreatorTest {
    
    public static testmethod void testCreateWithRecordType(){
        
        //Create admin user
        Profile adminProfile = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        
        User adminUser = new User(Alias = 'adni', Email='admin@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = adminProfile.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName='adminApexTestJim@admin.com');
        
        //Create standard user 
        Profile standardProfile = [SELECT Id FROM Profile WHERE Name='Standard User'];
        
        User standardUser = new User(Alias = 'standt', Email='standard@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = standardProfile.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName='standardApexTestJorge@admin.com');
        
        //Create Account as Admin User
        System.runAs(adminUser){
            AccountCreator.createWithRecordType();
        }
        
        System.runAs(standardUser){
            AccountCreator.createWithRecordType();
        }
        
        //query all the accounts as admin user
        System.runAs(adminUser){
            AccountCreator.queryAllAccounts();
        }
        
        //query all the accounts as standard user
        System.runAs(standardUser){
            AccountCreator.queryAllAccounts();
        }
        
    }
    
    

}