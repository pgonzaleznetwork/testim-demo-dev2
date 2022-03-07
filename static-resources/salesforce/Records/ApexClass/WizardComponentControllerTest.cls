@IsTest
public class WizardComponentControllerTest {
    
    public static testMethod void testSaveDataPositive(){
        
        Account a = new Account(Name='helloworkd');
        Contact c = new Contact(LastName='LastName');
        Opportunity o = new Opportunity(StageName='Closed - Won',CloseDate=Date.today(),Name='oppty');
        
        WizardComponentController.saveData(a, c, o);
        
    }
    
    public static testMethod void testSaveDataNegativeAccount(){
        
        Account a2 = new Account();
        Contact c2 = new Contact(LastName='LastName');
        Opportunity o2 = new Opportunity(StageName='Closed - Won',CloseDate=Date.today(),Name='oppty');
        
        WizardComponentController.saveData(a2, c2, o2);
        
    }
    
    public static testMethod void testSaveDataNegativeContact(){
        
        Account a3 = new Account(Name='helloworkd');
        Contact c3 = new Contact();
        Opportunity o3 = new Opportunity(StageName='Closed - Won',CloseDate=Date.today(),Name='oppty');
        
        WizardComponentController.saveData(a3, c3, o3);
        
    }
    
    public static testMethod void testSaveDataNegativeOppty(){
        
        Account a4 = new Account(Name='helloworkd');
        Contact c4 = new Contact(LastName='LastName');
        Opportunity o4 = new Opportunity();
        
        WizardComponentController.saveData(a4, c4, o4);
        
    }
    
}