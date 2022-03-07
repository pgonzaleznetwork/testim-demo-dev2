public class LeadSelector {
    
    
    public static List<Lead> selectLeadsForConversion(List<Id> recordIds){
        
        return [SELECT Id FROM Lead WHERE Id IN :recordIds];
        
    }

}