public class AllObjectsTriggerMonitor{
    
    
    private static Map<String,Boolean> firstRunObject = new Map<String,Boolean>{
        
        //this could be populated via custom settings
        'opportunity' => true,
         'account' => true
            
            };
    
    public static Boolean shouldTriggerRun(String sfObject){
        
        //if we don't support the event or if it's blank
        if(sfObject == '' || !firstRunObject.containsKey(sfObject)){
            return false;
        }else{
            if(firstRunObject.get(sfObject)){
                
                firstRunObject.put(sfObject, false);
                return true;
            }else{
                return firstRunObject.get(sfObject);
            }
        }
        
        
    }
    
}