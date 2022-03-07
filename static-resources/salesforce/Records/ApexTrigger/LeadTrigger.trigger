trigger LeadTrigger on Lead (before insert, before update, after update,after insert) {
    
    If(trigger.isBefore && trigger.isInsert){
        
        System.debug('executing before insert');
        
        LeadDedupeActions.processLeads(trigger.new);
        
    }

	If(trigger.isBefore && trigger.isUpdate){
        
        System.debug('executing before update');
        
        LeadDedupeActions.processLeads(trigger.new);
        
    }     

}