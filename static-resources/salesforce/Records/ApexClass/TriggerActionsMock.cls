public class TriggerActionsMock extends TriggerFramework.SObjectTriggerActions{
    
    public static String lastMethodCalled;
    
    public override void instantiateBeforeInsertActions(){
        beforeInsertActions.add(new BeforeInsertActionMock());
    }
    
    public override void instantiateAfterInsertActions(){
        afterInsertActions.add(new AfterInsertActionMock());
    }
    
    public override void instantiateBeforeUpdateActions(){
        beforeUpdateActions.add(new BeforeUpdateActionMock());
    }
    
    public override void instantiateAfterUpdateActions(){
        afterUpdateActions.add(new AfterUpdateActionMock());
    }
    
    public override void instantiateBeforeDeleteActions(){
        beforeDeleteActions.add(new BeforeDeleteActionMock());
    }
    
    public override void instantiateAfterDeleteActions(){
        afterDeleteActions.add(new AfterDeleteActionMock());
    }
    
    public override void instantiateAfterUndeleteActions(){
        afterUndeleteActions.add(new AfterUndeleteActionMock());
    }
    
    public class BeforeInsertActionMock extends TriggerFramework.TriggerAction{
        
        public override void fire(List<SObject> newRecords){
            lastMethodCalled = 'before insert';
        }  
    }
    
    public class AfterInsertActionMock extends TriggerFramework.TriggerAction{
        
        public override void fire(Map<Id,SObject> newRecords){
            lastMethodCalled = 'after insert';
        }  
    }
    
    public class BeforeUpdateActionMock extends TriggerFramework.TriggerAction{
        
        public override void fire(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
            lastMethodCalled = 'before update';
        }  
    }
    
    public class AfterUpdateActionMock extends TriggerFramework.TriggerAction{
        
        public override void fire(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
            lastMethodCalled = 'after update';
        }  
    }
    
    public class BeforeDeleteActionMock extends TriggerFramework.TriggerAction{
        
        public override void fire(Map<Id,SObject> oldRecords){
            lastMethodCalled = 'before delete';
        }  
    }
    
    public class AfterDeleteActionMock extends TriggerFramework.TriggerAction{
        
        public override void fire(Map<Id,SObject> oldRecords){
            lastMethodCalled = 'after delete';
        }  
    }
    
    public class AfterUndeleteActionMock extends TriggerFramework.TriggerAction{
        
        public override void fire(Map<Id,SObject> oldRecords){
            lastMethodCalled = 'after undelete';
        }  
    }

}