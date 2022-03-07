@IsTest
public class AccountTriggerActionsTests {
    
    @IsTest
    public static void when_AccountsAreInserted_Expect_DefaultWebsite(){
        
        List<Account> accounts = new List<Account>();
        
        for(Integer i=0; i < 200; i++){
            Account a = new Account();
            a.Name = 'Test Account '+i;
            accounts.add(a);
        }
        
        insert accounts;
        
        List<Account> insertedAccounts = [SELECT Id, Website FROM Account];
        
        for(Account acct : insertedAccounts){
            System.assert(acct.website == 'www.awesometrigger.com');
        }
        
    }
    
    @IsTest
    public static void when_AccountsAreInserted_Expect_DefaultPrimaryContact(){
        
        
        List<Account> accounts = new List<Account>();
        
        for(Integer i=0; i < 1; i++){
            Account a = new Account();
            a.Name = 'website2';
            accounts.add(a);
        }
        
       insert accounts;
               
        Map<Id,Account> insertedAccounts = new Map<Id,Account>([SELECT Id, website , numberOfEmployees FROM Account]);
        
        System.debug(JSON.serializePretty(insertedAccounts));
        
        for(Account a : insertedAccounts.values()){
            a.name = 'website';
        }
        
        update insertedAccounts.values();
        
        System.debug('Accounts were inserted: '+JSON.serialize(insertedAccounts));
        
        List<Contact> primaryContacts = [SELECT Id,AccountId,LastName FROM Contact WHERE AccountId IN :insertedAccounts.keySet()];
        
        System.assert(primaryContacts.size() == 1,'There should be one contact created per account.');
        
        for(Contact cont : primaryContacts){
            System.assert(cont.LastName == 'Primary');
        }
        
        
    }
    
}