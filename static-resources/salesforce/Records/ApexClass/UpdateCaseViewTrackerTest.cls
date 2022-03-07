@IsTest
public class UpdateCaseViewTrackerTest {
    
    @IsTest
    public static void testUpdateOwnerActiveTime(){
        
        Case contextCase = new Case();
        contextCase.Status = 'New';
        contextCase.Origin = 'Web';
        insert contextCase;
        
        Case insertedCase = [SELECT Id, Owner_Active_Time_in_Seconds__c FROM Case LIMIT 1][0];
        
        UpdateCaseViewTracker.updateOwnerActiveTime(insertedCase.Id,10.00);
        
        
    }

}