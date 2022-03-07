trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
    
    List<BatchLeadConvertErrors__c> errors = new List<BatchLeadConvertErrors__c>();
    
    for(BatchApexErrorEvent be : trigger.new){
        BatchLeadConvertErrors__c e = new BatchLeadConvertErrors__c();
        e.StackTrace__c = be.StackTrace;
        e.Records__c = be.JobScope;
        e.AsyncApexJobId__c = be.AsyncApexJobId;
        errors.add(e);
    }
    
    insert errors;

}