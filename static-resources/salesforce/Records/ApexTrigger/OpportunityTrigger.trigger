trigger OpportunityTrigger on Opportunity (before insert, before update, before delete,after insert, after update, after delete, after undelete) {
        
    TriggerDispatcher.run(new OpportunityTriggerHandler());

}