public class RecursiveTriggerHandler3 {
    
    
    
    public   class triggerEventSetting{
        
     private Map<String,Boolean> firstRunEventMap = new Map<String,Boolean>{
        
        'beforeInsert' => true,
        'beforeUpdate' => true,
        'afterInsert' => true,
        'afterUpdate' => true
        
    };
        
   
    public  Boolean shouldEventRun(String event){
        
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

}