@IsTest
public class AccountAddressTriggerClass_Test {
    
    public testMethod static void testUpdateBillingAddress(){
        
        Account a = new Account(Name='Test Account');
        a.Match_Billing_Address__c = true;
        a.BillingPostalCode = 'GA';
        
        Test.startTest();
        
        insert a;
        
        Test.stopTest();
        
        Account newAccount = [SELECT BillingPostalCode,ShippingPostalCode FROM 
                             Account WHERE id = :a.Id][0];
        
        System.assertEquals(newAccount.BillingPostalCode, newAccount.ShippingPostalCode);
    }

}