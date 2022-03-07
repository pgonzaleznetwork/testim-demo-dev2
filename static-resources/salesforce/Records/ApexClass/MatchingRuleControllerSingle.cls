public class MatchingRuleControllerSingle {
    
    
    /*******************************************************INSTANCE VARIABLES*********************************************************/
    
    private Matching_Rule__c matchingRule;

        
    /*******************************************************CONSTRUCTOR*********************************************************/
    
    
    public MatchingRuleControllerSingle(Matching_Rule__c matchingRule){
        
        MatchingRuleConfigurationChecker ruleChecker = new MatchingRuleConfigurationChecker();
        ruleChecker.validateConfig(new List<Matching_Rule__c>{matchingRule});
        
        this.matchingRule = matchingRule;
        
    }
    
    /*******************************************************PUBLIC METHODS*********************************************************/
    
    
    
    
    public MatchingRuleResult findMatchingRecords(Lead lead){
        
        MatchingRuleResult result;
        
        if(isTheMatchingFieldPopulated(lead)){
            
            List<SObject> matchingRecords = getRecordsFromSOQLQuery(lead);
            
            if(matchingRecords.size() > 0){
                
                result = createPositiveMatchingResult(lead,matchingRecords[0]);
            }else{
                result = createNegativeMatchingResult(lead);
            }
            
        }else{
            //if the matching field is not populated, we consider this a negative matching result
            result = createNegativeMatchingResult(lead);
        }
        
        return result;
        
    }
    
    public MatchingRuleResult findMatchingRecordsWithContext(MatchingRuleResult context){
        
        MatchingRuleResult result;
        
        //only if the field is populated do we run the check. In other words, we don't match on null values
        if(isTheMatchingFieldPopulated(context.lead)){
            
            List<SObject> matchingRecords;
            
            if(matchingRule.Type_of_Contact_to_Match__c == 'Parent'){
            
            	matchingRecords = getRecordsFromSOQLQueryWithSelfContext(context);
            
            }else if(matchingRule.Type_of_Contact_to_Match__c == 'Child'){
                
            	matchingRecords = getRecordsFromSOQLQueryWithAccountContext(context);
            }
            
            if(matchingRecords.size() > 0){
                
                result = new MatchingRuleResult(context.lead,matchingRecords[0]);
            }else{
                result = new MatchingRuleResult(context.lead);
            }
            
        }else{
             //if the matching field is not populated, we consider this a negative matching result
            result = new MatchingRuleResult(context.lead);
        }
                
        return result;
        
    }
    
    
    /*******************************************************PRIVATE METHODS*********************************************************/
    
    private MatchingRuleResult createPositiveMatchingResult(Lead lead, SObject matchingRecord){
        
        MatchingRuleResult result = new MatchingRuleResult(lead,true,matchingRecord);
        return result;
        
    }
    
    private List<SObject> getRecordsFromSOQLQueryWithAccountContext(MatchingRuleResult context){
        
		Object fieldValue = getFieldValueToFilterQuery(context.lead);
        
        //alias to improve readability of SOQL query
        Matching_Rule__c r = matchingRule;
        
        String soqlQuery;
        
        
        if(Schema.Contact.getSObjectType() == context.matchingRecord.getSObjectType()){
            
            Contact matchingContact = (Contact)context.matchingRecord;
            Id accountId = matchingContact.AccountId;
            
            soqlQuery = 'SELECT Id, AccountId,'+r.Matching_Field__c+' FROM '+r.Matching_Object__c+' WHERE '+r.Matching_Field__c+' = :fieldValue'+
            ' AND AccountId = :accountId';
            
            List<SObject> listOfMatchingObjects = Database.query(soqlQuery);
        	return listOfMatchingObjects;
            
            
        }else{
            throw new InvalidContextObjectException('The context from the current lead is not a contact');
        }
        
        
        
    }
    
    private List<SObject> getRecordsFromSOQLQueryWithSelfContext(MatchingRuleResult context){
        
        Object fieldValue = getFieldValueToFilterQuery(context.lead);
        
        //alias to improve readability of SOQL query
        Matching_Rule__c r = matchingRule;
        
        String soqlQuery;
        
        if(r.Matching_Object__c == 'Contact'){
            //query WHERE clause needs to include record type and country
        	 soqlQuery = 'SELECT Id, AccountId '+r.Matching_Field__c+' FROM '+r.Matching_Object__c+' WHERE '+r.Matching_Field__c+' = :fieldValue'+
            ' AND Id = :context.matchingRecord.Id';
        }else{
             soqlQuery = 'SELECT Id, '+r.Matching_Field__c+' FROM '+r.Matching_Object__c+' WHERE '+r.Matching_Field__c+' = :fieldValue'+
            ' AND Id = :context.matchingRecord.Id';
        }
        
        List<SObject> listOfMatchingObjects = Database.query(soqlQuery);
        return listOfMatchingObjects;
        
    }
    
    private MatchingRuleResult createNegativeMatchingResult(Lead lead){
        
        MatchingRuleResult result = new MatchingRuleResult(lead,false,null);
        return result;
    }
    
    private Boolean isTheMatchingFieldPopulated(Lead lead){
        
        sObject sObjectLead = lead;
        if(sObjectLead.get(matchingRule.Lead_Evaluated_Field__c) != null){
            return true;
        }else{
            return false;
        }
        
    }
    
    private List<SObject> getRecordsFromSOQLQuery(Lead lead){
        
        Object fieldValue = getFieldValueToFilterQuery(lead);
        
        //alias to improve readability of SOQL query
        Matching_Rule__c r = matchingRule;
        String soqlQuery;
        
        if(r.Matching_Object__c == 'Contact'){
            //query WHERE clause needs to include record type and country
        	 soqlQuery = 'SELECT Id, AccountId, '+r.Matching_Field__c+' FROM '+r.Matching_Object__c+' WHERE '+r.Matching_Field__c+' = :fieldValue';
        }else{
             soqlQuery = 'SELECT Id,'+r.Matching_Field__c+' FROM '+r.Matching_Object__c+' WHERE '+r.Matching_Field__c+' = :fieldValue';
        }
     
        List<SObject> listOfMatchingObjects = Database.query(soqlQuery);
        return listOfMatchingObjects;
        
        
    }
    
    private Object getFieldValueToFilterQuery(Lead lead){
        sObject sObjectLead = lead;
        Object fieldValue = sObjectLead.get(matchingRule.Lead_Evaluated_Field__c);
        return fieldValue;
    }
    
    
    private Map<String,SObject> getRecordsByMatchingField(List<SObject> listOfMatchingObjects){
        
        
        //should support dates in the future
        Map<String,SObject> mapMatchedObjectsByMatchingField = new Map<String,SObject>();
        
        for(SObject sObj : listOfMatchingObjects){
            mapMatchedObjectsByMatchingField.put((String)sObj.get(matchingRule.Matching_Field__c),sObj);
        }
        
        return mapMatchedObjectsByMatchingField;
        
    } 
    
    
    /*******************************************************INNER CLASSES*********************************************************/
    
    private class InvalidFieldException extends Exception{}
    
    public class MatchingRuleResult{
        
        public Lead lead;
        public Boolean didItMatch;
        public sObject matchingRecord;
        
        public MatchingRuleResult(Lead lead, Boolean didItMatch,sObject matchingRecord){
            this.lead = lead;
            this.didItMatch = didItMatch;
            this.matchingRecord = matchingRecord;
        }
        
        public MatchingRuleResult(Lead lead){
            this(lead,false,null);
        }
        
        public MatchingRuleResult(Lead lead, sObject matchingObject){
            this(lead,true,matchingObject);
        }
        
    }
    
    public class InvalidContextObjectException extends Exception{}
    
    
}