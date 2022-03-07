public class RecursiveTriggerHandler2 {

    private static Map<String,Boolean> firstRunEventMap = new Map<String,Boolean>{
        
        'beforeInsert' => true,
        'beforeUpdate' => true,
        'afterInsert' => true,
        'afterUpdate' => true
        
    };
        
   
    public static Boolean shouldEventRun(String event){
        
        //if we don't support the event or if it's blank
        if(event == '' || !firstRunEventMap.containsKey(event)){
            return false;
        }else{
            if(firstRunEventMap.get(event)){
                                
                firstRunEventMap.put(event, false);
                return true;
            }else{
                return firstRunEventMap.get(event);
            }
        }
        
        
    }

}