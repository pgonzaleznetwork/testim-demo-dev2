public class LeadDedupeActions {
    
    
    public static void processLeads(List<Lead> leads){
        
        List<String> relevantFields = new List<String>{'CurrentGenerators__c','Date_of_Birth__c'};
        
        for(Lead lead : leads){
            
            if(FieldValue.allHaveChanged(lead, relevantFields)){
                System.debug('Doing some processing!');
            }
            
        }
        
    }
    


}