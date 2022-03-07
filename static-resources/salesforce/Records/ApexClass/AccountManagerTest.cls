@IsTest
public class AccountManagerTest {
    
    @TestSetup
    static void createTestAccount(){
        Account a = new Account(Name='Account',RequiredField__c='Hello',Field_Being_Used__c = 'a');
        insert a;
        
        Contact c = new Contact(LastName='LastName',AccountId=a.Id);
        insert c;
    }
    
    public testMethod static void testGetAccount(){
        
        Id accountId = [SELECT Id FROM Account WHERE Name = 'Account' LIMIT 1][0].Id;
        
        RestRequest restRequest = new RestRequest();
        restRequest.requestURI = 'https://resourceful-moose-448750-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+accountId+'/contacts';
        restRequest.httpMethod = 'GET';
        restRequest.addHeader('Content-Type', 'application/json');
        RestContext.request = restRequest;
        
        Account returnedAccount = AccountManager.getAccount();
        
        //the account should have one contact
        System.assertEquals(returnedAccount.Contacts.size(), 1);

        
    }

}