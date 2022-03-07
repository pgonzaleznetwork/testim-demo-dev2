public class MatchingRuleConfigurationChecker {
    
    public void validateConfig(List<Matching_Rule__c> matchingRules){
        
        for(Matching_Rule__c matchingRule : matchingRules){
            
            if(!isMatchingRuleConfigValid(matchingRule)){
                
                throw new MatchingRuleConfigurationException('The Field or Object'
                +' references in this Matching Rule are incorrect. Please make sure '+
                 'you are using the correct API names.');
            }
        }
        
    }
    
    private Boolean isMatchingRuleConfigValid(Matching_Rule__c matchingRule){
        
        if(isLeadEvaluatedFieldValid(matchingRule) && isMatchingObjectValid(matchingRule) 
           && isMatchingFieldValid(matchingRule)){
            return true;
        }else{
            return false;
        }        
    }
    
    private Boolean isLeadEvaluatedFieldValid(Matching_Rule__c matchingRule){
        
        Map<String,Schema.SObjectField> leadObjectFields = Lead.getSObjectType().getDescribe().fields.getMap();
        
        String fieldAPIName = matchingRule.Lead_Evaluated_Field__c;
        
        if(leadObjectFields.containsKey(fieldAPIName)){
            return true;
        }else{
            throw new InvalidFieldException(fieldAPIName+' is not a valid API field name in the Lead object. Please review the Matching Rule.');
        }        
    }
    
    private Boolean isMatchingObjectValid(Matching_Rule__c matchingRule){
        
        SObjectType matchingObjectAPIname = Schema.getGlobalDescribe().get(matchingRule.Matching_Object__c);
        
        if(matchingObjectAPIname == null){
            return false;
        }else{
            return true;
        }
    }
    
    private Boolean isMatchingFieldValid(Matching_Rule__c matchingRule){
        
        if(isMatchingObjectValid(matchingRule)){
            
            SObjectType objectName = Schema.getGlobalDescribe().get(matchingRule.Matching_Object__c);
            
            Map<String,Schema.SObjectField> fieldsByName = objectName.getDescribe().fields.getMap();
            
            if(fieldsByName.containsKey(matchingRule.Matching_Field__c)){
            	return true;
            }else{
                throw new InvalidFieldException(matchingRule.Matching_Field__c+' is not a valid API field name in the '+objectName +
                                                ' object.Please review the Matching Rule');
            }   
            
        }
        return false;
        
    }
    
    private class InvalidFieldException extends Exception{}
    private class MatchingRuleConfigurationException extends Exception{}

}