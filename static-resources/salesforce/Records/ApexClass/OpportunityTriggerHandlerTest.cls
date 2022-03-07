@IsTest
public class OpportunityTriggerHandlerTest {
    
    public testMethod static void testTriggerStatusCustomMetadata(){
        
        TriggerStatus__mdt triggerStatus = [SELECT Disabled__c FROM TriggerStatus__mdt WHERE label = 'OpportunityTriggerHandler'][0];
        
        System.assertEquals(true, triggerStatus.Disabled__c);
        
    }
    
    public testMethod static void testTriggerStatusCustomSetting(){
        TriggerSettings__c triggerSetting = TriggerSettings__c.getInstance('OpportunityTriggerHandler');
        System.assertEquals(true, triggerSetting.Disabled__c); 
    }

}