public class MatchingRuleController {
    
    
    /*******************************************************INSTANCE VARIABLES*********************************************************/
    
    private Matching_Rule__c matchingRule;
    private List<Lead> leadsThatMatched;
    private List<Lead> leadsThatDidNotMatch;
    
    
    
    
    /*******************************************************CONSTRUCTOR*********************************************************/
    
    
    public MatchingRuleController(Matching_Rule__c matchingRule){
        this.matchingRule = matchingRule;
        leadsThatMatched = new List<Lead>();
        leadsThatDidNotMatch = new List<Lead>();
        
    }
    
    /*******************************************************PUBLIC METHODS*********************************************************/
    
    
    public void findMatchingRecords(List<Lead> leads){
        
        MatchingRuleConfigurationChecker ruleChecker = new MatchingRuleConfigurationChecker();
        ruleChecker.validateConfig(new List<Matching_Rule__c>{matchingRule});
        
        List<SObject> matchingRecords = getRecordsFromSOQLQuery(leads);
        
        Map<String,SObject> recordsByMatchingField = getRecordsByMatchingField(matchingRecords);
        sortLeadsByMatchingResult(recordsByMatchingField,leads);         
        
    }
    
    public List<Lead> getLeadsThatMatched(){
        return leadsThatMatched;
    }
    
    public List<Lead> getLeadsThatDidNotMatch(){
        return leadsThatDidNotMatch;
    }
    
    /*******************************************************PRIVATE METHODS*********************************************************/
        
    //doesn't support dates at the moment
    private List<String> getListOfFieldValuesToEvaluate(List<Lead> leadsWithPopulatedFieldValues){
        
        List<String> fieldValuesToEvaluate = new List<String>();
        
        for(Lead lead : leadsWithPopulatedFieldValues){
            
            SObject leadObj = lead;
            Object fieldValue = leadObj.get(matchingRule.Lead_Evaluated_Field__c);
            fieldValuesToEvaluate.add((String)fieldValue);
            
        }  
        return fieldValuesToEvaluate;
        
    }
    
    private SortedLeadList sortLeadsBasedOnNullValues(List<Lead> leads){
        
        
        List<Lead> leadsWithEmptyFieldValues = new List<Lead>();
        List<Lead> leadsWithPopulatedFieldValues = new List<Lead>();
        
        for(Lead lead : leads){
            SObject leadObj = lead;
            Object fieldValue = leadObj.get(matchingRule.Lead_Evaluated_Field__c);
            
            if(fieldValue == null){
                leadsWithEmptyFieldValues.add(lead);
            }else{
                leadsWithPopulatedFieldValues.add(lead);
            }        
        }
        
        SortedLeadList sortedLeadList = new SortedLeadList(leadsWithEmptyFieldValues,leadsWithPopulatedFieldValues);
        return SortedLeadList;
    }
    
    private List<SObject> getRecordsFromSOQLQuery(List<Lead> leads){
        
        SortedLeadList sortedLeadList = sortLeadsBasedOnNullValues(leads);
        List<String> valuesToMatchQuery = getListOfFieldValuesToEvaluate(sortedLeadList.leadsWithPopulatedFieldValues);
        
        //alias to improve readability of SOQL query
        Matching_Rule__c r = matchingRule;
        
        //query WHERE clause needs to include record type and country
        String soqlQuery = 'SELECT Id, '+r.Matching_Field__c+' FROM '+r.Matching_Object__c+' WHERE '+r.Matching_Field__c+' IN: valuesToMatchQuery';
        
        List<SObject> listOfMatchingObjects = Database.query(soqlQuery);
        return listOfMatchingObjects;
        
    }
    
    
    private Map<String,SObject> getRecordsByMatchingField(List<SObject> listOfMatchingObjects){
        
        
        //should support dates in the future
        Map<String,SObject> mapMatchedObjectsByMatchingField = new Map<String,SObject>();
        
        for(SObject sObj : listOfMatchingObjects){
            mapMatchedObjectsByMatchingField.put((String)sObj.get(matchingRule.Matching_Field__c),sObj);
        }
        
        return mapMatchedObjectsByMatchingField;
        
    } 
    
    private void sortLeadsByMatchingResult(Map<String,SObject> matchingRecords,List<Lead> leads){
        
        SortedLeadList sortedLeadList = sortLeadsBasedOnNullValues(leads);
        
        for(Lead lead : sortedLeadList.leadsWithPopulatedFieldValues){
            
            SObject leadObj = lead;
            //should support dates
            String fieldValue = (String)leadObj.get(matchingRule.Lead_Evaluated_Field__c);
            if(matchingRecords.containsKey(fieldValue)){
                leadsThatMatched.add(lead);
            }else{
                leadsThatDidNotMatch.add(lead);
            }
        }
        //leads with empty values would not have a matching record, so we add them to the list of records
        //that didn't match
        leadsThatDidNotMatch.addAll(sortedLeadList.leadsWithEmptyFieldValues);
        
    }
    
    
    
    /*******************************************************INNER CLASSES*********************************************************/
    
    private class InvalidFieldException extends Exception{}
    
    private class SortedLeadList{
        
        private List<Lead> leadsWithEmptyFieldValues;
        private List<Lead> leadsWithPopulatedFieldValues;
        
        SortedLeadList(List<Lead> leadsWithEmptyFieldValues,List<Lead> leadsWithPopulatedFieldValues){
            this.leadsWithEmptyFieldValues = leadsWithEmptyFieldValues;
            this.leadsWithPopulatedFieldValues = leadsWithPopulatedFieldValues;
        }
    }
    
    
}