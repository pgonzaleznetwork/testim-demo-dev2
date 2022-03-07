public class OpportunityTriggerHandler implements ITriggerHandler {
    
    
    public Boolean isDisabled(){
        /*
         * Retrieve value from custom settings
         * 
         * TriggerSettings__c triggerSetting = TriggerSettings__c.getInstance('OpportunityTriggerHandler');
        return triggerSetting.Disabled__c;*/
        
        /*
         *New version using Custom Metadata Types 
         */
        TriggerStatus__mdt triggerStatus = [SELECT Disabled__c FROM TriggerStatus__mdt WHERE label = 'OpportunityTriggerHandler'][0];
        return triggerstatus.Disabled__c;
        
        
    }
    
    public void beforeInsert(List<SObject> newItems){
        System.debug('executing before insert');
    }
    
    public void beforeUpdate(Map<Id,SObject> newItems,Map<Id,SObject> oldItems){
        System.debug('executing before update');       
    }
    
    public void beforeDelete(Map<Id,SObject> oldItems){
        System.debug('executing before delete');
    }
    
    public void afterInsert(Map<Id,SObject> newItems){

	    System.debug('Executing after insert');        
        
    }
    
    public void afterUpdate(Map<Id,SObject> newItems,Map<Id,SObject> oldItems){
        
                
        if(AllObjectsTriggerMonitor.shouldTriggerRun('opportunity')){
            System.debug('executing after after');
        }else{
            System.debug('after update trigger not running a second time');
        }
       
    }
    
    public void afterDelete(Map<Id,SObject> oldItems){
        System.debug('executing after delete');
    }
    
    public void afterUndelete(Map<Id,SObject> oldItems){
        System.debug('executing after undelete');
    }
    
}