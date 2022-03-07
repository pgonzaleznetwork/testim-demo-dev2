trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    
    ClosedOpportunityTriggerClass.createTaskOnClosedWon(trigger.new);

}