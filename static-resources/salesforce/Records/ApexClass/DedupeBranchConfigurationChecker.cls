public class DedupeBranchConfigurationChecker {
    
    public void validateConfiguration(List<Dedupe_Branch__c> branches){
        
        for(Dedupe_Branch__c branch : branches){
            
            if(!areFieldReferencesInBranchValid(branch)){
                throw new InvalidDedupeBranchConfigurationException('The field references in this Dedupe Branch are incorrect. Please make sure '+
                 'you are using the correct API names.');
            }
        }
        
    }
    
    private Boolean areFieldReferencesInBranchValid(Dedupe_Branch__c dedupeBranchRecord){
        
        
        Map<String,Schema.SObjectField> leadObjectFields = Lead.getSObjectType().getDescribe().fields.getMap();
        
        Boolean isFirstFieldReferenceValid = isFieldReferenceValid(leadObjectFields,dedupeBranchRecord.True_Set_This_Field__c);
        Boolean isSecondFieldReferenceValid = isFieldReferenceValid(leadObjectFields,dedupeBranchRecord.False_Set_This_Field__c);
        
        if(isFirstFieldReferenceValid && isSecondFieldReferenceValid){
            return true;
        }else{
            return false;
        }
        
    }
    
    private Boolean isFieldReferenceValid(Map<String,Schema.SObjectField> leadFields,String fieldAPIname){
        
        if(fieldAPIname == null || leadFields.containsKey(fieldAPIname)){
            return true;
        }else if(fieldAPIname != null && !leadFields.containsKey(fieldAPIname)){
            return false;
        }
        
        return false;
        
    }
    
    private class InvalidDedupeBranchConfigurationException extends Exception{}

}