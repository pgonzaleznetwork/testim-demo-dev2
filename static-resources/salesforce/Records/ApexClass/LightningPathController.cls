public class LightningPathController {
    
    @AuraEnabled
    public static Id getRecordId(){
        List<Energy_Audit__c> audits = [SELECT Id,Name FROM Energy_Audit__c limit 1];
        Id recordId = audits[0].id;
        return recordId;
    }

}