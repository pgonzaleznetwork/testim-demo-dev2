/*
 * This class provides a generic implementation to handling all the trigger execution contexts. Every SObject that supports
 * triggers must extend this class. Where needed, the sub-class can override the methods that execute actions on a particular
 * trigger context.
*/
public virtual class SObjectTriggerHandler {
    
    /*
     * Every SObject that supports trigger is expected to implement this interface, which provides methods for
     * getting all the relevant trigger actions. 
	*/
    protected TriggerFramework.SObjectTriggerActions actions;
    protected TriggerFramework.TriggerRecursion recursionCheck;
    
    /*
     * As records can re-enter a trigger multiple times within the same transaction, the variables below support the 
     * routing of re-entrant records to different methods were only actions that support recursion are fired again.
	*/
    @TestVisible
    private static Set<Id> recordsAlreadyProcessed = new Set<Id>();
    
    protected Map<Id,SObject> firstEntryOldRecords = new Map<Id,SObject>();
    protected Map<Id,SObject> firstEntryNewRecords = new Map<Id,SObject>();   
    protected Map<Id,SObject> reEntryOldRecords = new Map<Id,SObject>();
    protected Map<Id,SObject> reEntryNewRecords = new Map<Id,SObject>();
            
    /*
     * Used to be able to test if the reentry methods are called when the trigger context is executed a 2nd or N time, and
     * to test if recursion checks work as expected.
	*/
    @TestVisible
    private static Boolean executingBeforeUpdateReEntry = false;
    @TestVisible
    private static Boolean executingAfterUpdateReEntry = false;
   
    
     
    public virtual void beforeInsert(List<SObject> newRecords){
        
        for(TriggerFramework.TriggerAction action : actions.getBeforeInsertActions()){
            action.fire(newRecords);
        }    
    }
    
  
    public virtual void afterInsert(Map<Id,SObject> newRecords){     
        
        for(TriggerFramework.TriggerAction action : actions.getAfterInsertActions()){            
            action.fire(newRecords);
        }    
    }
    
    
    public virtual void beforeUpdate(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
        
        if(recursionCheck.beforeUpdateLimitExceeded()){
            return;
        }
           
        sortByFirstEntry(oldRecords,newRecords);
        
        if(reEntryNewRecords.size() > 0){
            beforeUpdateReEntry(reEntryOldRecords,reEntryNewRecords);
        }
        
        for(TriggerFramework.TriggerAction action : actions.getBeforeUpdateActions()){
            action.fire(firstEntryOldRecords,firstEntryNewRecords);
        }
    }
    
    /*
     * Separate the records in the trigger context depending on whether this is the first time they enter the trigger context
     * or whether they are re-entrant records.
	*/
    protected virtual void sortByFirstEntry(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){

        for(Id recordId : newRecords.keySet()){
            if(hasAlreadyBeenProcessed(recordId)){
                reEntryOldRecords.put(recordId,oldRecords.get(recordId));
                reEntryNewRecords.put(recordId,newRecords.get(recordId));
            }else{
                firstEntryOldRecords.put(recordId,oldRecords.get(recordId));
                firstEntryNewRecords.put(recordId,newRecords.get(recordId));
                markAsProcessed(newRecords);
            }
        }     
    }
    
    
    protected Boolean hasAlreadyBeenProcessed(Id recordId){
        return recordsAlreadyProcessed.contains(recordId);
    }
    
    protected void markAsProcessed(Map<Id,SObject> records){       
        
        for(Id recordId : records.keySet()){
            recordsAlreadyProcessed.add(recordId);
        }     
    }
    
    public void beforeUpdateReentry(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
        
        executingBeforeUpdateReEntry = true;
        
        for(TriggerFramework.TriggerAction action : actions.getBeforeUpdateActions()){
            if(action.allowsRecursion()){
                action.fire(oldRecords,newRecords);  
            }
        }
    }
    
 
    public void afterUpdate(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
        
        if(recursionCheck.afterUpdateLimitExceeded()){
            return;
        }
        
        sortByFirstEntry(oldRecords,newRecords);
        
        if(reEntryNewRecords.size() > 0){
            afterUpdateReEntry(reEntryOldRecords,reEntryNewRecords);
        }
        
        for(TriggerFramework.TriggerAction action : actions.getAfterUpdateActions()){
            action.fire(firstEntryOldRecords,firstEntryNewRecords);
        }
    }
    
    public void afterUpdateReentry(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
        
        executingAfterUpdateReEntry = true;
        
        for(TriggerFramework.TriggerAction action : actions.getAfterUpdateActions()){
            if(action.allowsRecursion()){
                action.fire(oldRecords,newRecords);  
            }
        }
    }
    
    public void beforeDelete(Map<Id,SObject> oldRecords){
        
        for(TriggerFramework.TriggerAction action : actions.getBeforeDeleteActions()){            
            action.fire(oldRecords);
        }        
    }
    
    
    public void afterDelete(Map<Id,SObject> oldRecords){
        
        for(TriggerFramework.TriggerAction action : actions.getAfterDeleteActions()){            
            action.fire(oldRecords);
        }  
    }
        
    public void afterUndelete(Map<Id,SObject> oldRecords){
        
        for(TriggerFramework.TriggerAction action : actions.getAfterUndeleteActions()){            
            action.fire(oldRecords);
        }   
    }
        
    public virtual Boolean isDisabled(){
        return false;
    }   
}