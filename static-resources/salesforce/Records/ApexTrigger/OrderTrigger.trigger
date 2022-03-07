trigger OrderTrigger on Order (before update) {
    
    EarPlugWithSharing.seeAllRecords();

}