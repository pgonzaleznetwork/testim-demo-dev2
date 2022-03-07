public class UpdateCaseViewTracker {
    

    @AuraEnabled
    public static void updateOwnerActiveTime(Id caseId,Decimal numberOfSeconds){
        System.debug('Case Id : '+caseId+' -- Number of Seconds: '+numberOfSeconds);
        Case contextCase = [SELECT Id, Owner_Active_Time_in_Seconds__c  FROM Case WHERE Id = :caseId LIMIT 1][0];
        contextCase.Owner_Active_Time_in_Seconds__c = contextCase.Owner_Active_Time_in_Seconds__c+numberOfSeconds;
        update contextCase;
    } 

}