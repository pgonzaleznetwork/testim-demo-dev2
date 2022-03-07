/*
 * This class is responsible for calling the different available methods of an instance of SObjectTriggerHandler
 * depending on the trigger context being executed.
 * 
 * Every trigger must reference this class to run the actions of the SObjectTriggerHandler implementation for that 
 * particular SObject.
*/
public class TriggerContextRouter {
    
    public static void run(SObjectTriggerHandler handler){
        
        if(handler.isDisabled()){
            return;
        }
        
        if(Trigger.IsBefore && Trigger.IsInsert){ 
            handler.beforeInsert(trigger.new);      
        }
        
        if(Trigger.IsAfter && Trigger.IsInsert){
            handler.afterInsert(trigger.newMap);
        }
               
        if(Trigger.IsBefore && Trigger.IsUpdate){
            handler.beforeUpdate(trigger.oldMap,trigger.newMap);
        }
        
        if(Trigger.IsAfter && Trigger.IsUpdate){
            handler.afterUpdate(trigger.oldMap,trigger.newMap);
        }
               
        if(Trigger.IsBefore && Trigger.IsDelete){
            handler.beforeDelete(trigger.oldMap);
        }
        
        if(Trigger.IsAfter && Trigger.IsDelete){
            handler.afterDelete(trigger.oldMap);
        }
        
        if(Trigger.IsAfter && Trigger.IsUndelete){
            handler.afterunDelete(trigger.oldMap);
        }
    }   
}