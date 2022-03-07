public class CaseTriggerHandler2 implements ITriggerHandler {
    


    public Boolean isDisabled(){
        
        TriggerSettings__c triggerSetting = TriggerSettings__c.getInstance('OpportunityTriggerHandler');
        return triggerSetting.Disabled__c;
    }
    
    public void beforeInsert(List<SObject> newItems){
        System.debug('executing before insert');
    }
    
    public void beforeUpdate(Map<Id,SObject> newItems,Map<Id,SObject> oldItems){
                
        if(RecursiveTriggerHandler2.shouldEventRun('beforeUpdate')){
            System.debug('Executing beforeUpdate for the first time');
        }else{
            System.debug('beforeUpdate NOT executed a second time');
        }
                
    }
    
    public void beforeDelete(Map<Id,SObject> oldItems){
        System.debug('executing before delete');
    }
    
    public void afterInsert(Map<Id,SObject> newItems){
        System.debug('executing after insert');
    }
    
    public void afterUpdate(Map<Id,SObject> newItems,Map<Id,SObject> oldItems){
        System.debug('executing after update');
       
    }
    
    public void afterDelete(Map<Id,SObject> oldItems){
        System.debug('executing after delete');
    }
    
    public void afterUndelete(Map<Id,SObject> oldItems){
        System.debug('executing after undelete');
    }
    
}