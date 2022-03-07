@IsTest
public class AccountServiceTests {
    
    @IsTest
    public static void testRemoveWebsite(){
        
        List<Account> accounts = new List<Account>();
        
        for(Integer i=0; i < 200 ; i++){
            Account acct = new Account();
            acct.Website = '';
            accounts.add(acct);
        }
        
        for(Account acct : accounts){
            System.assert(acct.website == '','Website should be null when instantiated');
        }
        
        AccountService.addDefaultWebsite(accounts);
        
        for(Account acct : accounts){
            System.assert(acct.website == 'www.awesometrigger.com','Website should have been modified.');
        }
        
    }
    
    @IsTest
    public static void testCreateDefaultPrimaryContact(){
        
        List<Account> accounts = new List<Account>();
        
        for(Integer i=0; i < 200 ; i++){
            Account acct = new Account();
            acct.Name = 'Test Account';
            accounts.add(acct);
        }
        
        insert accounts;
        
        Map<Id,Account> insertedAccounts = new Map<Id,Account>([SELECT Id FROM Account]);
        
        AccountService.createDefaultPrimaryContact(insertedAccounts.values());
        
        List<Contact> primaryContacts = [SELECT Id,AccountId,LastName FROM Contact WHERE AccountId IN :insertedAccounts.keySet()];
        
        System.assert(primaryContacts.size() == 200,'There should be one contact created per account.');
        
        for(Contact cont : primaryContacts){
            System.assert(cont.LastName == 'Primary');
        }
        
    }

}