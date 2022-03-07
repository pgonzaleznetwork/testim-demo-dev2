public abstract class TriggerAction {
    
     public abstract String getName();
        
     public virtual Boolean allowsRecursion(){
            return false;
     }
    
    public virtual void fire(List<SObject> newRecords){
        
    }
        
    public virtual void fire(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
        
    }
        
    public virtual void fire(Map<Id,SObject> newOrDeletedRecords){
        
    }

    
    //sample class
    
    public class DefaultWebsite extends TriggerAction{
        
        public override String getName(){
            return DefaultWebsite.class.toString();
        }
        
        public override void fire(List<SObject> newRecords){
          AccountService.addDefaultWebsite( (List<Account>) newRecords );
    	}
        
        public override void fire(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
            //filtering logic here
            AccountService.addDefaultWebsite( (List<Account>) newRecords.values() );
        }
        
    }
    
    public class DeleteParentAccountOrders extends TriggerAction{
        
        public override String getName(){
            return DeleteParentAccountOrders.class.toString();
        }
        
        public override void fire(Map<Id,SObject> deletedAccounts){
            //filtering and call service
        }
        
    }

}