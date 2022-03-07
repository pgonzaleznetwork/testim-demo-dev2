public class TriggerActionsOld {
    
    public Interface BeforeInsert{
        
        void executeAction(List<SObject> records);
        
    }
    
    public Interface AfterInsert{
        
        void executeAction(List<SObject> records);
    }
    
    public Interface BeforeUpdate{
        
        Boolean conditionIsMet(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords);
    
        void executeAction();
    }
    
    public Interface AfterUpdate{
                
        Boolean conditionIsMet(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords);
    
        void executeAction();
        
    }
    
    public abstract class AfterUpdateAB{
        
        protected List<Lead> leads;
        
        public virtual void executeIfCriteriaIsMet(){
            if(conditionIsMet()){
                try{
                     executeAction();
                }catch(Exception e){
                    handleException(e);
                }
               
            }
        }
                
        protected abstract Boolean conditionIsMet();
        
        protected abstract void executeAction();
        
        protected abstract void handleException(Exception e);
        
    }
    
    public Interface AfterDelete{
        
    }
    
    public Interface AfterUndelete{
        
    }

}