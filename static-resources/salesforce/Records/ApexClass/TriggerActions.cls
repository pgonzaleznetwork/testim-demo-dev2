/*
 * This class defines multiple wrappers that represent trigger actions that are fired on a specific trigger context.
 * 
 * Each SObject that has triggers should have a class(es) listing the different actions that can fire on a particular trigger context.
 * Each action should be wrapped using the abstract class that matches the trigger context. 
 *
 * For example, to call the AccountService.defaultWebsite() method on BeforeInsert, the method should be wrapped on a BeforeInsertAction
 * class and it should implement all abstract methods. 
*/
public class TriggerActions {
    
    //what are the higher level of abstractions here?
    
    
    public abstract class BeforeInsertAction{//unique
        
        public abstract String getName();
        
        public virtual Boolean allowsRecursion(){
            return false;
        }
        
        public virtual void fire(List<SObject> newRecords){  
            callService(newRecords);
        } 
        protected abstract void callService(List<SObject> newRecords);    
    }
    
    
    public abstract class AfterInsertAction{//same as delete
        
        public virtual Boolean allowsRecursion(){
            return false;
        }
        
        public virtual void fire(Map<Id,SObject> newRecords){
            callService(newRecords.values());     
        }  
        protected abstract void callService(List<SObject> newRecords);   
    }
    
    
    public abstract class BeforeUpdateAction{//same as update counterpart
        
        public virtual Boolean allowsRecursion(){
            return false;
        }
        
		public abstract String getName();
		        
        protected List<SObject> matchingRecords = new List<SObject>();
        
        public virtual void evaluateCriteriaAndFire(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){

            if(criteriaIsMet(oldRecords,newRecords)){               
                callService();            
            }
        }
        protected abstract Boolean criteriaIsMet(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords);
        protected abstract void callService();           
    }
    
    
    public abstract class AfterUpdateAction{//same as update counterpart
        
        public virtual Boolean allowsRecursion(){
            return false;
        }
        
        protected List<SObject> matchingRecords;
        
        public virtual void evaluateCriteriaAndFire(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
            
            if(criteriaIsMet(oldRecords,newRecords)){          
                callService();
            }
        }      
        protected abstract Boolean criteriaIsMet(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords);
        protected abstract void callService();   
    }
    
    
    public abstract class BeforeDeleteAction{//same as after insert
                
        public virtual void fire(Map<Id,SObject> oldRecords){    
            callService(oldRecords.values());
        }
        protected abstract void callService(List<SObject> oldRecords);
        
    }
    
    
    public abstract class AfterDeleteAction{//same as after insert
                
        public virtual void fire(Map<Id,SObject> oldRecords){  
            callService(oldRecords.values());
        }
        
        protected abstract void callService(List<SObject> oldRecords);  
    }
    
    
    public abstract class AfterUndeleteAction{//same as after insert
        
        public virtual void fire(Map<Id,SObject> oldRecords){  
            callService(oldRecords.values());
        }   
        protected abstract void callService(List<SObject> oldRecords);
        
    }
    

    
}