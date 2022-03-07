public class OpportunityRecursiveTriggerHandler {
    
    public static Boolean isFirstRun = true;
    
    public static Boolean shouldItRun(){
        if(isFirstRun){
            isFirstRun = false;
            return true;
        }else{
            return isFirstRun;
        }
    }

}