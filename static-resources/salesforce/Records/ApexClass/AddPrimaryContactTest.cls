@IsTest
public class AddPrimaryContactTest {
    
    @TestSetup
    static void createAccountsAndContact(){
        
        //list of accounts for job
        List<Account> accountsToInsert = new List<Account>();
        
        //create contact for queueable job
        Contact contact = new Contact(FirstName='Pablo',LastName='Gonzalez11');
        insert contact;
        
        //create accounts
        for(Integer x=0; x < 100; x++){
            if(x < 50){
                Account acct = new Account(Name='Acct'+x,BillingState='NY',RequiredField__c='test');
                accountsToInsert.add(acct);
            }else{
                Account acct = new Account(Name='Acct'+x,BillingState='CA',RequiredField__c='test');
                accountsToInsert.add(acct);
            }
        }
        
        insert accountsToInsert;
    }
    
    public testMethod static void testAddPrimaryContactQueuableJob(){
        
        Test.startTest();
        
        //enqueue the job
        System.enqueueJob(new AddPrimaryContact([SELECT Id,LastName FROM Contact][0],'CA'));
        
        Test.stopTest();
        
        //get the ids for the created accounts
        Map<Id,Account> accountIds = new Map<Id,Account>([SELECT Id,BillingState FROM Account
                                                         WHERE BillingState = 'CA']);
        
        //check that there are 50 contacts, one per account
        System.assertEquals(50, [SELECT COUNT() FROM Contact WHERE AccountId IN :accountIds.keySet()]);
    }

}