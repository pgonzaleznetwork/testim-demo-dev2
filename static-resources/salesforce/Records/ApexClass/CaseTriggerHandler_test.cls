/**=====================================================================
* Name: CaseTriggerHandler_test
* Description: [Test class for CaseTriggerHandler]
* Created Date: [3/5/2015]
* Created By: Appirio JDC
* 
* Date Modified		Modified By    			Description of the update
* Mar 05 2015    	Ralf Hoffmann       	made specific for just the case time bucket tests
=====================================================================*/
@isTest
private class CaseTriggerHandler_test {
    static Account testAccount;
    static Contact testContact;
    static QueueSobject testCaseQueue;
    static testMethod void testCaseTriggerHandler(){
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator' limit 1];
        User sysAdmin1 = createTestUser(true,pro);
        User sysAdmin2 = createTestUser(true,pro);
        ID timeTrackingRTid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Case Time Tracking').getRecordTypeId();
        System.runAs(sysAdmin1){
            
            Test.startTest();
            
            testAccount = createTestAccount(true);
            testCaseQueue = createTestQueue(true,'Case');

            //Insert 2 custom setting for Time Tracking
            List<Case_Status_Bucket__c> buckets = new List<Case_Status_Bucket__c>();
            Case_Status_Bucket__c testBucket1 = new Case_Status_Bucket__c(Name='New', Time_Bucket__c='Resolution Time Bucket');
            buckets.add(testBucket1);
            Case_Status_Bucket__c testBucket2 = new Case_Status_Bucket__c(Name='In Progress', Time_Bucket__c='Resolution Time Bucket');
            buckets.add(testBucket2);
            insert buckets;
            
            //Insert 2 new cases
            List<Case> cases = new List<Case>();
            Case testCase1 = new case(status='New', Origin='Web', subject='Test case 1', RecordTypeId=timeTrackingRTid);
            cases.add(testCase1);
            Case testCase2 = new case(status='New', Origin='Web', subject='Test case 2', RecordTypeId=timeTrackingRTid);
            cases.add(testCase2);
            insert cases;
 
            //Update status and owner(queue) on case 1
            testCase1.status = 'In Progress';
            update testCase1;
            testCase1.OwnerId = testCaseQueue.QueueId;
            update testCase1;
            //Update status and owner(user) on Case2;
            testCase2.status = 'In Progress';
            update testCase2;
            testCase2.OwnerId = sysAdmin2.Id;
            update testCase2;
            
            Test.stopTest();
        }
    }
    
    //============ static Test Utility methods ============
    public static User createTestUser(boolean isInsert, Profile pro) {
        User user = new User(alias = 'testUser', email='standarduser' + Math.random()  + '@testorg.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                             localesidkey='en_US', profileid = pro.Id, timezonesidkey='America/Los_Angeles', 
                             username='teststandarduser' + Math.random() + '@testorg.com', IsActive=true,
                             CompanyName = 'test Company');
        if(isInsert) {
            insert user;
        }
        return user;
    }
    public static QueueSobject createTestQueue(boolean isInsert, string type) {
        //because queues require a related group record, first create the group
        //for type use the SobjectType for which the queue should be created
        Group queueGroup = new Group(Name = 'Queue'+Math.random(), Type = 'Queue');
        insert queueGroup;
        QueueSobject queue = new QueueSobject(SobjectType = type, QueueId = queueGroup.Id);
        if(isInsert) {   
            insert queue;
        }
        return queue;
    }    
    
    public static Account createTestAccount(Boolean isInsert) {
        Account account = new Account(Name = 'Test'+ Math.random());
        if(isInsert) {
            insert account;
        }
        return account;
    }
    
}