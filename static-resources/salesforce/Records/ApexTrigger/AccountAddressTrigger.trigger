trigger AccountAddressTrigger on Account (before insert,before update) {
    
    AccountAddressTriggerClass.updateBillingAddress(trigger.new); 

}