/*
 * This class serves as a namespace/package for 2 of the main classes that support the trigger framework.
*/
public class TriggerFramework {

    /*
     * SObjects that support triggers must extend this class to wrap any method/functionality that should be 
     * callable from a particular trigger context. 
	*/
    public abstract class TriggerAction {
   		
        /*
         * If set to true, the action can be executed again for records that are entering the trigger context for the 2nd
         * or N time.
		*/
        public virtual Boolean allowsRecursion(){
            return false;
        }  
        
        /*
         * Implement the required version of the overloaded method depending on the trigger context variables available
         * to a particular trigger context.
		*/
        public virtual void fire(List<SObject> newRecords){}
        public virtual void fire(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){}
        public virtual void fire(Map<Id,SObject> newOrDeletedRecords){}    
    }
    
   
    /*
     * SObjects that support triggers must extend this class in a class dedicated to hold all the available
     * trigger actions for that object, which would be implementations of TriggerFramework.TriggerAction.
	*/
    public virtual class SObjectTriggerActions {
        
        
        protected List<TriggerFramework.TriggerAction> beforeInsertActions;
        protected List<TriggerFramework.TriggerAction> afterInsertActions;
        
        protected List<TriggerFramework.TriggerAction> beforeUpdateActions;
        protected List<TriggerFramework.TriggerAction> afterUpdateActions;
        
        protected List<TriggerFramework.TriggerAction> beforeDeleteActions;
        protected List<TriggerFramework.TriggerAction> afterDeleteActions;
        protected List<TriggerFramework.TriggerAction> afterUndeleteActions;
        
        
        public SObjectTriggerActions(){
            
            beforeInsertActions = new List<TriggerFramework.TriggerAction>();
            afterInsertActions = new List<TriggerFramework.TriggerAction>();
            beforeUpdateActions = new List<TriggerFramework.TriggerAction>();
            afterUpdateActions = new List<TriggerFramework.TriggerAction>();
            beforeDeleteActions = new List<TriggerFramework.TriggerAction>();
            afterDeleteActions = new List<TriggerFramework.TriggerAction>();
            afterUndeleteActions = new List<TriggerFramework.TriggerAction>();         
        }
        
        
        public List<TriggerFramework.TriggerAction> getBeforeInsertActions(){
            
            if(beforeInsertActions.isEmpty()){
                instantiateBeforeInsertActions();
            }       
            return beforeInsertActions;        
        }
        
        /*
         * Needs to be implemented by the sub-class as a way of storing TriggerFramework.TriggerAction instances
         * that are relevant to this particular trigger context.
		*/
        protected virtual void instantiateBeforeInsertActions(){}

        
        public List<TriggerFramework.TriggerAction> getAfterInsertActions(){
            
            if(afterInsertActions.isEmpty()){
                instantiateAfterInsertActions();
            }
            return afterInsertActions;   
        }
        
        /*
         * Needs to be implemented by the sub-class as a way of storing TriggerFramework.TriggerAction instances
         * that are relevant to this particular trigger context.
		*/
        protected virtual void instantiateAfterInsertActions(){}
            
  
        public List<TriggerFramework.TriggerAction> getBeforeUpdateActions(){
            
            if(beforeUpdateActions.isEmpty()){
                instantiateBeforeUpdateActions();
            }
            
            return beforeUpdateActions;
            
        }
        
        /*
         * Needs to be implemented by the sub-class as a way of storing TriggerFramework.TriggerAction instances
         * that are relevant to this particular trigger context.
		*/
        protected virtual void instantiateBeforeUpdateActions(){}
            
    
        public List<TriggerFramework.TriggerAction> getAfterUpdateActions(){
            
            if(afterUpdateActions.isEmpty()){
                instantiateAfterUpdateActions();
            }
            
            return afterUpdateActions;
            
        }
        
        /*
         * Needs to be implemented by the sub-class as a way of storing TriggerFramework.TriggerAction instances
         * that are relevant to this particular trigger context.
		*/
        protected virtual void instantiateAfterUpdateActions(){}
            
        
        public List<TriggerFramework.TriggerAction> getBeforeDeleteActions(){
            
            if(beforeDeleteActions.isEmpty()){
                instantiateBeforeDeleteActions();
            }
            
            return beforeDeleteActions;
            
        }
        
        /*
         * Needs to be implemented by the sub-class as a way of storing TriggerFramework.TriggerAction instances
         * that are relevant to this particular trigger context.
		*/
        protected virtual void instantiateBeforeDeleteActions(){}
                
        
        public List<TriggerFramework.TriggerAction> getAfterDeleteActions(){
            
            if(afterDeleteActions.isEmpty()){
                instantiateAfterDeleteActions();
            }
            
            return afterDeleteActions;
            
        }
        
        /*
         * Needs to be implemented by the sub-class as a way of storing TriggerFramework.TriggerAction instances
         * that are relevant to this particular trigger context.
		*/
        protected virtual void instantiateAfterDeleteActions(){}
                
        
        public List<TriggerFramework.TriggerAction> getAfterUndeleteActions(){
            
            if(afterUndeleteActions.isEmpty()){
                instantiateAfterUndeleteActions();
            }
            
            return afterUndeleteActions;
            
        }
        
        /*
         * Needs to be implemented by the sub-class as a way of storing TriggerFramework.TriggerAction instances
         * that are relevant to this particular trigger context.
		*/
        protected virtual void instantiateAfterUndeleteActions(){}
           
    }
    
    public interface TriggerRecursion{
        
        Boolean beforeUpdateLimitExceeded();
        Boolean afterUpdateLimitExceeded();
        
    }
       
}