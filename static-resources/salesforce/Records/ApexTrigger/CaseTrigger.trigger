/**=============================================================
 * Name: CaseTrigger
 * Description: 
 * Created Date: [3/2/2015]
 * Created By: Appirio JDC
 * 
 * Date Modified                Modified By               Description of the update
 * 
 ===============================================================*/      

trigger CaseTrigger on Case (before insert, after insert, before update, after update) {
    
    
    if(trigger.isAfter && trigger.isInsert){
        CaseTriggerHandler.afterInsert(trigger.new);
    }else if(trigger.isBefore && trigger.isInsert){
           CaseTriggerHandler.beforeInsert(trigger.new);
    }else if(trigger.isAfter && trigger.isUpdate){
           CaseTriggerHandler.afterUpdate(trigger.new);
     }else if(trigger.isbefore && trigger.isUpdate){
          CaseTriggerHandler.beforeUpdate(trigger.new);
     }
}