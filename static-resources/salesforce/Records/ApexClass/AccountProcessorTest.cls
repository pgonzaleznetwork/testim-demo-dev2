@IsTest
public class AccountProcessorTest {
    
    public testMethod static void testCountContactsPositive(){
        
        List<Id> acctIds = createAccountsWithContacts(2,1);
        
        Test.startTest();
        AccountProcessor.countContacts(acctIds);
        Test.stopTest();
        
        Account acct = [SELECT Id, Number_of_Contacts__c,(SELECT Id FROM Contacts) 
                        FROM Account WHERE Id IN : acctIds][0];
        
        System.assertEquals(acct.Contacts.size(), acct.Number_of_Contacts__c);
        
    }
    
    public testMethod static void testCountContactsNegative(){
                
        List<Id> acctIds = createAccountsWithContacts(2,1);
        
        Map<Id,Account> acctsToUpdate = new Map<Id,Account>([SELECT Id,RequiredField__c FROM
                                        Account WHERE Id  IN :acctIds]);
        
        for(Account acct : acctsToUpdate.values()){
            acct.RequiredField__c = '';
        }
        
        System.debug('acctsToUpdate inside test class '+acctsToUpdate.values());
        
        acctIds = new List<Id>(acctsToUpdate.keySet());
        
      
        Test.startTest();
        AccountProcessor.countContacts(acctIds);
        Test.stopTest();
        
        Account acct = [SELECT Id, Number_of_Contacts__c,(SELECT Id FROM Contacts) 
                        FROM Account WHERE Id IN : acctIds][0];
        
        System.assertEquals(acct.Contacts.size(), acct.Number_of_Contacts__c);
        
    }
    
    private static List<Id> createAccountsWithContacts(Integer numOfAccounts,Integer contactsPerAccount){
        
        
        List<Account> acctsToInsert = new List<Account>();
        List<Contact> contactsToInsert = new List<Contact>();
        
        for(Integer x=0; x < numOfAccounts; x++){
            Account a = new Account(name='acctName'+x);
            a.RequiredField__c = 'hello';
            acctsToInsert.add(a);
            
        }
        
        try{
            insert acctsToInsert;
            System.debug('inserted accts: '+acctsToInsert);
        }catch(Exception e){
            System.debug('Error inserting accounts '+e.getMessage());
            
        }
        
        Map<Id,Account> accounts = new Map<Id,Account>(acctsToInsert);
        
        for(Id acctId : accounts.keySet()){
            for(Integer y=0; y < contactsPerAccount ; y++){
                Contact c = new Contact(LastName='RandomContact'+y);
                c.AccountId = acctId;
                contactsToInsert.add(c);
            }
        }
        
        if(contactsToInsert.size() > 0){
            try{
                insert contactsToInsert;
            }catch(Exception e){
                System.debug('Error inserting contacts '+e.getMessage());
            }
        }
        
        List<Id> accountIds = new List<Id>(accounts.keySet());
        return accountIds;
    }
    
}