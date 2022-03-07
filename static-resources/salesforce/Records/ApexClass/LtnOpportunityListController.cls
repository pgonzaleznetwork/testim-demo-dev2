public class LtnOpportunityListController {
    
    @AuraEnabled
    public static List<Opportunity> getOpptys(Id accountId){
        return [SELECT Name,StageName,Amount,CloseDate
               FROM Opportunity WHERE AccountId = :accountId];
    }

}