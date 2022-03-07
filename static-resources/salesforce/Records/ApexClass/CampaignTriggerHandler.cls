public class CampaignTriggerHandler extends SObjectTriggerHandler{
    
    /*
     * Used to limit how many times the beforeUpdate and afterUpdate contexts can be called within a single
     * trigger transaction.
	*/
    public static final Integer BEFORE_UPDATE_RECURSION_LIMIT = 2;
    public static final Integer AFTER_UPDATE_RECURSION_LIMIT = 2;
    
    private static Integer beforeUpdateExecutionsSoFar = 0;
    private static Integer afterUpdateExecutionsSoFar = 0;
    
        
    public CampaignTriggerHandler(){
        actions = new CampaignTriggerActions();
        recursionCheck = new CampaignTriggerRecursion();
    }
    
    public class CampaignTriggerRecursion implements TriggerFramework.TriggerRecursion{
        
        public Boolean beforeUpdateLimitExceeded(){       
            beforeUpdateExecutionsSoFar++;
           	return beforeUpdateExecutionsSoFar > BEFORE_UPDATE_RECURSION_LIMIT;              
        }
        
        public Boolean afterUpdateLimitExceeded(){          
            afterUpdateExecutionsSoFar++;        
            return afterUpdateExecutionsSoFar > AFTER_UPDATE_RECURSION_LIMIT;            
        }       
    }

    
    public override Boolean isDisabled(){
        return false;
    } 
    
    
}