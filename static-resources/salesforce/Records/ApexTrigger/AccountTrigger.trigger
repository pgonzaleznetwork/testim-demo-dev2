trigger AccountTrigger on Account (before insert, after insert , before update, after update, before delete, after delete, after undelete)
{
    
    switch on Trigger.operationType {
        
        //other operations would go here
        
        when BEFORE_INSERT {
             AccountCustomError.putError(trigger.new);
        }
    }          
}