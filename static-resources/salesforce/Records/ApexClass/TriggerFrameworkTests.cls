@IsTest
public class TriggerFrameworkTests {
    
	public static SObjectTriggerHandler handler = new SObjectTriggerHandlerMock();
    public static String fakeRecordId = '0010O00001qg2gG';
    
    
    @IsTest
    public static void when_BeforeInsertIsCalled_BeforeInsertActions_ShouldBe_Executed(){
        
        List<SObject> newRecords = new List<SObject>();
        
        handler.beforeInsert(newRecords);
        
        System.assert(TriggerActionsMock.lastMethodCalled == 'before insert');
    }
    
    @IsTest
    public static void when_AfterInsertIsCalled_AfterInsertActions_ShouldBe_Executed(){
        
        Map<Id,SObject> newRecords = new Map<Id,SObject>();
        
        handler.afterInsert(newRecords);
        
        System.assert(TriggerActionsMock.lastMethodCalled == 'after insert');
    }
    
    @IsTest
    public static void when_BeforeUpdateIsCalled_BeforeUpdateActions_ShouldBe_Executed(){
        
        Map<Id,SObject> oldRecords = new Map<Id,SObject>();
        Map<Id,SObject> newRecords = new Map<Id,SObject>();
            
        handler.beforeUpdate(oldRecords,newRecords);
        
        System.assert(TriggerActionsMock.lastMethodCalled == 'before update');
    }
    
    @IsTest
    public static void when_AfterUpdateIsCalled_AfterUpdateActions_ShouldBe_Executed(){
        
        Map<Id,SObject> oldRecords = new Map<Id,SObject>();
        Map<Id,SObject> newRecords = new Map<Id,SObject>();
            
        handler.afterUpdate(oldRecords,newRecords);
        
        System.assert(TriggerActionsMock.lastMethodCalled == 'after update');
    }
    
    
    @IsTest
    public static void when_BeforeDeleteIsCalled_BeforeDeleteActions_ShouldBe_Executed(){
        
        Map<Id,SObject> oldRecords = new Map<Id,SObject>();
        
        handler.beforeDelete(oldRecords);
        
        System.assert(TriggerActionsMock.lastMethodCalled == 'before delete');
    }
    
     @IsTest
    public static void when_AfterDeleteIsCalled_AfterDeleteActions_ShouldBe_Executed(){
        
        Map<Id,SObject> oldRecords = new Map<Id,SObject>();
        
        handler.afterDelete(oldRecords);
        
        System.assert(TriggerActionsMock.lastMethodCalled == 'after delete');
    }
    
    @IsTest
    public static void when_AfterUndeleteIsCalled_AfterUndeleteActions_ShouldBe_Executed(){
        
        Map<Id,SObject> oldRecords = new Map<Id,SObject>();
        
        handler.afterUndelete(oldRecords);
        
        System.assert(TriggerActionsMock.lastMethodCalled == 'after undelete');
    }
    
    @IsTest
    public static void when_RecordIsProcessed_TheRecordId_ShouldBe_MarkedAsProcessed(){
        
        Map<Id,SObject> oldRecords = new Map<Id,SObject>();
        Map<Id,SObject> newRecords = new Map<Id,SObject>();
        
        oldRecords.put(fakeRecordId,new Account());
        newRecords.put(fakeRecordId,new Account());
        
        handler.beforeUpdate(oldRecords, newRecords);
        
        System.assert(SObjectTriggerHandler.recordsAlreadyProcessed.contains(fakeRecordId));
                
    }
    
    @IsTest
    public static void when_BeforeUpdateIsRecursive_BeforeUpdateReEntry_ShouldBe_Executed(){
        
        Map<Id,SObject> oldRecords = new Map<Id,SObject>();
        Map<Id,SObject> newRecords = new Map<Id,SObject>();
        
        oldRecords.put(fakeRecordId,new Account());
        newRecords.put(fakeRecordId,new Account());
        
        handler.beforeUpdate(oldRecords, newRecords);       
        handler.beforeUpdate(oldRecords, newRecords); // call it one more time to simulate a recursive trigger call
        
        System.assert(SObjectTriggerHandler.executingBeforeUpdateReEntry);
                
    }
    
    @IsTest
    public static void when_AfterUpdateIsRecursive_AfterUpdateReEntry_ShouldBe_Executed(){
        
        Map<Id,SObject> oldRecords = new Map<Id,SObject>();
        Map<Id,SObject> newRecords = new Map<Id,SObject>();
        
        oldRecords.put(fakeRecordId,new Account());
        newRecords.put(fakeRecordId,new Account());
        
        /*Call it one more time to simulate a recursive trigger call.*/
        handler.afterUpdate(oldRecords, newRecords);       
        handler.afterUpdate(oldRecords, newRecords); 
        
        System.assert(SObjectTriggerHandler.executingAfterUpdateReEntry);
                
    }
    
    @IsTest
    public static void when_BeforeUpdateRecursionIsExceeded_Processing_ShouldBe_Stopped(){
        
        Map<Id,SObject> oldRecords = new Map<Id,SObject>();
        Map<Id,SObject> newRecords = new Map<Id,SObject>();
        
        oldRecords.put(fakeRecordId,new Account());
        newRecords.put(fakeRecordId,new Account());
        
        /*Execute the method more times than the allowed limit.*/
        for(Integer i=1; i <= SObjectTriggerHandlerMock.BEFORE_UPDATE_RECURSION_LIMIT+1 ; i++){
            handler.beforeUpdate(oldRecords, newRecords);
        }
             
        System.assert(SObjectTriggerHandlerMock.beforeUpdateLimitExceeded);
                
    }
    
    @IsTest
    public static void when_AfterUpdateRecursionIsExceeded_Processing_ShouldBe_Stopped(){
        
        Map<Id,SObject> oldRecords = new Map<Id,SObject>();
        Map<Id,SObject> newRecords = new Map<Id,SObject>();
        
        oldRecords.put(fakeRecordId,new Account());
        newRecords.put(fakeRecordId,new Account());
        
        /*Execute the method more times than the allowed limit.*/
        for(Integer i=1; i <= SObjectTriggerHandlerMock.AFTER_UPDATE_RECURSION_LIMIT+1 ; i++){
            handler.afterUpdate(oldRecords, newRecords);
        }
             
        System.assert(SObjectTriggerHandlerMock.afterUpdateLimitExceeded);
                
    }
}