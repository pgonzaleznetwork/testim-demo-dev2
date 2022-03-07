public class LeadTriggerClass {
    
    public static void syncLeadsToMarketo(List<Lead> leads){
        MarketoAPIRequest request = new MarketoAPIRequest(leads);
        Id MarketoAPIRequestJobId = System.enqueueJob(request);
        System.debug('MarketoAPIRequestJobId: '+MarketoAPIRequestJobId);
    }

}