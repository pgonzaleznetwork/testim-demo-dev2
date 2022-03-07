@IsTest
public class EmailRoutingEngine_Test {
    
    public static testMethod void testRules(){
        
        Case aCase = new Case();
        aCase.subject = 'testSubject';
        insert aCase;
        
        Email_Routing_Rule__c rule = new Email_Routing_Rule__c();
        rule.Name = 'test rule';
        rule.Business_Unit__c = 'Germany';
        insert rule;
        
        Email_Routing_Rule_Filter__c filter = new Email_Routing_Rule_Filter__c();
        filter.Email_Routing_Rule__c = rule.Id;
        filter.Email_Attribute__c = 'Subject';
        filter.Operator__c = 'Equals';
        filter.Value__c = 'testSubject';
        
        insert filter;
        
        Email_Routing_Field_Mapping__c fieldMapping = new Email_Routing_Field_Mapping__c();
        fieldMapping.Business_Unit__c = 'Germany Advantage';
        fieldMapping.Email_Routing_Rule__c = rule.Id;
        fieldMapping.Case_Type__c = 'Order';
        
        insert fieldMapping;
        
        
        EmailMessage email = new EmailMessage();
        email.ParentId = aCase.Id;
        email.Subject = 'testSubject';
        insert email;
        
        
    }

}