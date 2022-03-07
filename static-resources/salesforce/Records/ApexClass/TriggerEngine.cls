public class TriggerEngine {
    
    private static Set<TriggerActions.BeforeUpdateAction> beforeUpdateActionsAlreadyExecuted;
    
    private static Set<String> actionsAlreadyExecuted;
    
    {
        beforeUpdateActionsAlreadyExecuted = new Set<TriggerActions.BeforeUpdateAction>();
        actionsAlreadyExecuted = new Set<String>();
    }
    
    public static void run(TriggerActions.BeforeUpdateAction action){
        
        
        
        if(hasBeenExecuted(action) && canBeCalledRecursively(action)){
            //action.evaluateCriteriaAndFire(oldRecords, newRecords)
        }
        
       
        
        beforeUpdateActionsAlreadyExecuted.add(action);
        
    }
    
    private static Boolean hasBeenExecuted(TriggerActions.BeforeUpdateAction action){
        
        return beforeUpdateActionsAlreadyExecuted.contains(action);
        
    }
    
    private static Boolean canBeCalledRecursively(TriggerActions.BeforeUpdateAction action){
        
        return action.canBeCalledRecursively();
    }

}