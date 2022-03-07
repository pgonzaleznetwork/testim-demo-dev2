public class SObjectTriggerHandlerMock extends SObjectTriggerHandler{
    
    public static final Integer BEFORE_UPDATE_RECURSION_LIMIT = 2;
    private static Integer beforeUpdateExecutionsSoFar = 0;
    public static final Integer AFTER_UPDATE_RECURSION_LIMIT = 2;
    private static Integer afterUpdateExecutionsSoFar = 0;
    private static Boolean beforeUpdateRecursionLimitExceeded = false;
    @TestVisible
    private static Boolean beforeUpdateLimitExceeded = false;
    @TestVisible
    private static Boolean afterUpdateLimitExceeded = false;
    
    public class MockTriggerRecursion implements TriggerFramework.TriggerRecursion{
        
        public Boolean beforeUpdateLimitExceeded(){       
            beforeUpdateExecutionsSoFar++;
            
            if(beforeUpdateExecutionsSoFar > BEFORE_UPDATE_RECURSION_LIMIT){
                beforeUpdateLimitExceeded = true;
                return beforeUpdateLimitExceeded;
            }
            
            return false;
        }
        
        public Boolean afterUpdateLimitExceeded(){  
            
            afterUpdateExecutionsSoFar++; 
            
            if(afterUpdateExecutionsSoFar > AFTER_UPDATE_RECURSION_LIMIT){
                afterUpdateLimitExceeded = true;
                return afterUpdateLimitExceeded;
            }
            
            return false;
        }       
    }
    	
    public SObjectTriggerHandlerMock(){
        actions = new TriggerActionsMock();
        recursionCheck = new MockTriggerRecursion();
    }
    
    
    
}