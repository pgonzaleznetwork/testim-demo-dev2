@IsTest
public class AccountTriggerHandlerTests {
    
    @IsTest
    public static void testDistributeTotal_baseCase(){
        
        Integer contactsPerAccount = 5;
        
        List<Account> accounts = getAccountsWithContacts(1,contactsPerAccount);
        
        assertDefaultValues(accounts);
        
        Decimal accountTotal = 100;
        
        for(Account acct : accounts){
            acct.Total__c = accountTotal;
        }
        
        Test.startTest();
        update accounts;
        Test.stopTest();
        
        Decimal expectedShare = accountTotal / contactsPerAccount;
        
        for(Contact contact : [SELECT Id,Share__c FROM Contact]){
            System.assert(contact.Share__c == expectedShare,'The expected share for this contact is '+expectedShare+' because each account has '+contactsPerAccount+' contacts');
        }     
    }
    
    @IsTest
    public static void testDistributeTotal_baseCaseNegativeValue(){
        
        Integer contactsPerAccount = 5;
        
        List<Account> accounts = getAccountsWithContacts(1,contactsPerAccount);
        
        assertDefaultValues(accounts);
        
        Decimal accountTotal = -100;
        
        for(Account acct : accounts){
            acct.Total__c = accountTotal;
        }
        
        Test.startTest();
        update accounts;
        Test.stopTest();
        
        Decimal expectedShare = accountTotal / contactsPerAccount;
        
        for(Contact contact : [SELECT Id,Share__c FROM Contact]){
            System.assert(contact.Share__c == expectedShare,'The expected share for this contact is '+expectedShare+' because each account has '+contactsPerAccount+' contacts');
        }     
    }
    
    @IsTest
    public static void testDistributeTotal_baseCaseInBulk(){
        
        Integer contactsPerAccount = 5;
        
        //400 accounts
        List<Account> accounts = getAccountsWithContacts(400,contactsPerAccount);
        
        assertDefaultValues(accounts);
        
        Decimal accountTotal = 100;
        
        for(Account acct : accounts){
            acct.Total__c = accountTotal;
        }
        
        Test.startTest();
        update accounts;
        Test.stopTest();
        
        Decimal expectedShare = accountTotal / contactsPerAccount;
        
        for(Contact contact : [SELECT Id,Share__c FROM Contact]){
            System.assert(contact.Share__c == expectedShare,'The expected share for this contact is '+expectedShare+' because each account has '+contactsPerAccount+' contacts');
        }     
    }
    
    @IsTest
    public static void testDistributeTotal_shareIsRemovedWhenTotalIsZero(){
        
        //we start with the base case
        
        Integer contactsPerAccount = 5;
        
        List<Account> accounts = getAccountsWithContacts(1,contactsPerAccount);
        
        assertDefaultValues(accounts);
        
        Decimal accountTotal = 100;
        
        for(Account acct : accounts){
            acct.Total__c = accountTotal;
        }
        
        update accounts;
      
        Decimal expectedShare = accountTotal / contactsPerAccount;
        
        for(Contact contact : [SELECT Id,Share__c FROM Contact]){
            System.assert(contact.Share__c == expectedShare,'The expected share for this contact is '+expectedShare+' because each account has '+contactsPerAccount+' contacts');
        }    
        
        //now we change the value to 0, here's the real test 
        
        accountTotal = 0;
        
        for(Account acct : accounts){
            acct.Total__c = accountTotal;
        }
        
        Test.startTest();
        update accounts;
        Test.stopTest();
      
        expectedShare = null;
        
        for(Contact contact : [SELECT Id,Share__c FROM Contact]){
            System.assert(contact.Share__c == expectedShare,'The expected share for this contact is a null value because the account total__c is zero');
        }    
    }
    
    @IsTest
    public static void testDistributeTotal_shareIsRemovedWhenTotalIsNull(){
        
        //we start with the base case
        
        Integer contactsPerAccount = 5;
        
        List<Account> accounts = getAccountsWithContacts(1,contactsPerAccount);
        
        assertDefaultValues(accounts);
        
        Decimal accountTotal = 100;
        
        for(Account acct : accounts){
            acct.Total__c = accountTotal;
        }
        
        update accounts;
      
        Decimal expectedShare = accountTotal / contactsPerAccount;
        
        for(Contact contact : [SELECT Id,Share__c FROM Contact]){
            System.assert(contact.Share__c == expectedShare,'The expected share for this contact is '+expectedShare+' because each account has '+contactsPerAccount+' contacts');
        }    
        
        //now we change the value to null, here's the real test 
        
        accountTotal = null;
        
        for(Account acct : accounts){
            acct.Total__c = accountTotal;
        }
        
        Test.startTest();
        update accounts;
        Test.stopTest();
      
        expectedShare = null;
        
        for(Contact contact : [SELECT Id,Share__c FROM Contact]){
            System.assert(contact.Share__c == expectedShare,'The expected share for this contact is a null value because the account total__c is zero null');
        }    
    }
    
    /*
     * This is a pure unit test (i.e without relying on a DML/trigger) which can help us debug this functionality if it ever breaks
     * i.e is it the trigger or the combination of the trigger and other automation (workflows, processes, etc)
	*/
    //@IsTest
    public static void testDistributeTotal_baseCaseWithoutTrigger(){
        
        Integer contactsPerAccount = 5;
        
        //we need the record on the db because the code being tested 
        Account account = getAccountsWithContacts(1,contactsPerAccount)[0];
        account.Total__c = 100;
        update account;
        
		//the test starts here
        
        Decimal accountTotal = 100;
        
        //simulating the trigger context variables
        Map<Id,Account> oldRecords = new Map<Id,Account>();
		Map<Id,Account> newRecords = new Map<Id,Account>();
            
        Account oldAccount = new Account();
        oldAccount.Total__c = 0;  
        oldRecords.put(account.Id,oldAccount);
        
        
        Account newAccount = new Account();
        newAccount.Total__c = 100;      
        newRecords.put(account.Id,newAccount);
          
        Test.startTest();
        //calling the method directly
        AccountTriggerHandler.distributeTotal(oldRecords, newRecords);
        Test.stopTest();
        
        Decimal expectedShare = accountTotal / contactsPerAccount;
        
        for(Contact contact : [SELECT Id,Share__c FROM Contact]){
            System.assert(contact.Share__c == expectedShare,'The expected share for this contact is '+expectedShare+' because each account has '+contactsPerAccount+' contacts. Actual value: '+contact.Share__c);
        }     
    }
    
    /********************************************************************* PRIVATE IMPLEMENTATION METHODS ***********************************************/
    
    private static void assertDefaultValues(List<Account> accounts){
        
        for(Account acct : accounts){
            
            System.assert(acct.Total__c == null,'The test should always start with Total__c being null');
            
            for(Contact contact : acct.contacts){
                
                System.assert(contact.Share__c == null,'The test should always start with Total__c being null');
            } 
        }
    }
    
    
    private static List<Account> getAccountsWithContacts(Integer numOfAccounts,Integer contactsPerAccount){
        
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();
        
        for(Integer i=0 ; i < numOfAccounts ; i++){
            
            Account acct = new Account();
            acct.Name = 'Test '+i;  
            
            accounts.add(acct);
        }
        
        insert accounts;
        
        for(Account acct : accounts){
            
            for(Integer i=0 ; i < contactsPerAccount ; i++){
            
                Contact contact = new Contact();
                contact.lastName = 'Test '+i;
                contact.AccountId = acct.Id;
                
                contacts.add(contact);
        	}   
        }
        
        insert contacts;
        
        //we query them to return them to the caller in such a way that the caller doesn't have to query
        //for the contacts and the relevant fields
        return [SELECT Id,Total__c,(SELECT Id,AccountId,Share__c FROM Contacts) FROM Account];   
    }

}