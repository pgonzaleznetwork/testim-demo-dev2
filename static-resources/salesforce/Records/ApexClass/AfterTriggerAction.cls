public interface AfterTriggerAction {
    
    Boolean conditionIsMet(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords);
    
    void executeAction();

}