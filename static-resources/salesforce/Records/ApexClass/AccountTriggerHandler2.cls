public class AccountTriggerHandler2 implements ITriggerHandler{
    
    TriggerFramework.SObjectTriggerActions actions;
    
    private static Set<Id> recordsAlreadyProcessed = new Set<Id>();
    Map<Id,SObject> firstEntryOldRecords = new Map<Id,SObject>();
    Map<Id,SObject> firstEntryNewRecords = new Map<Id,SObject>();   
    Map<Id,SObject> reEntryOldRecords = new Map<Id,SObject>();
    Map<Id,SObject> reEntryNewRecords = new Map<Id,SObject>();
      
    public static final Integer BEFORE_UPDATE_RECURSION_LIMIT = 2;
    private static Integer beforeUpdateExecutionsSoFar = 0;
    public static final Integer AFTER_UPDATE_RECURSION_LIMIT = 2;
    private static Integer afterUpdateExecutionsSoFar = 0;
    
    public static final Integer BEFORE_INSERT_RECURSION_LIMIT = 2;
    private static Integer beforeInsertExecutionsSoFar = 0;
    public static final Integer AFTER_INSERT_RECURSION_LIMIT = 2;
    private static Integer afterInsertExecutionsSoFar = 0;
    
    
    
    public AccountTriggerHandler2(){     
        actions = new AccountTriggerActions(); 
        
    }
    
    public void beforeInsert(List<SObject> newRecords){
        for(TriggerFramework.TriggerAction action : actions.getBeforeInsertActions()){
            action.fire(newRecords);
        }    
    }
    
    
    public void afterInsert(Map<Id,SObject> newRecords){     
        for(TriggerFramework.TriggerAction action : actions.getAfterInsertActions()){            
            action.fire(newRecords);
        }    
    }
    
    
    public void beforeUpdate(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
        
        beforeUpdateExecutionsSoFar++;
        
        if(beforeUpdateExecutionsSoFar > BEFORE_UPDATE_RECURSION_LIMIT){
            return;
        }
        
        sortByFirstEntry(oldRecords,newRecords);
        
        if(reEntryNewRecords.size() > 0){
            beforeUpdateReEntry(reEntryOldRecords,reEntryNewRecords);
        }
        
        for(TriggerFramework.TriggerAction action : actions.getBeforeUpdateActions()){
            action.fire(oldRecords,newRecords);
        }
    }
    
    private void sortByFirstEntry(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
        
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
    
    private Boolean hasAlreadyBeenProcessed(Id recordId){
        return recordsAlreadyProcessed.contains(recordId);
    }
    
    private void markAsProcessed(Map<Id,SObject> records){
        
        for(Id recordId : records.keySet()){
            recordsAlreadyProcessed.add(recordId);
        }
        
    }
    
    public void beforeUpdateReentry(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
        
        for(TriggerFramework.TriggerAction action : actions.getBeforeUpdateActions()){
            if(action.allowsRecursion()){
                action.fire(oldRecords,newRecords);  
            }
        }
    }
    
    public void afterUpdateReentry(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
        /*
* do the same but check if the action allows recursion
*/
    }
    
    
    public void afterUpdate(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
        
        afterUpdateExecutionsSoFar++;
        
        if(afterUpdateExecutionsSoFar > AFTER_UPDATE_RECURSION_LIMIT){
            return;
        }        
    }
    
    public void beforeDelete(Map<Id,SObject> oldItems){
        
    }
    
    public void afterDelete(Map<Id,SObject> oldRecords){
        
    }
    
    public void afterUndelete(Map<Id,SObject> oldRecords){
        
    }
    
    public Boolean isDisabled(){
        return false;
    }
    

    
    
    
    
    
}