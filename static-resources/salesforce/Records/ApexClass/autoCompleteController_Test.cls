/**
Test class to provide test coverage to autoCompleteController.cls
 */
@isTest
private class autoCompleteController_Test {

    static testMethod void testAutocomplete() {
        
        Account account = new Account(Name = 'Test Account', Type = 'Customer');
        insert account;
        
        Test.startTest();
        
	        List<Account> listAccount = (List<Account>) autoCompleteController.findSObjects('Account', 'Test', 'Type');
	        System.assert(listAccount != null, 'Should return one account');	
	        System.assert(listAccount[0].Name == 'Test Account', 'Account Name should contains "test"');
        	
        Test.stopTest();
    }
}