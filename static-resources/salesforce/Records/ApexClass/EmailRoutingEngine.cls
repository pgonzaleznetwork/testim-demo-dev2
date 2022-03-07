public class EmailRoutingEngine {
    
    
    private Map<Id,Email_Routing_Rule__c> rulesThatMatchedPerCaseId = new Map<Id,Email_Routing_Rule__c>();
    
    
    public void processEmailsThroughRoutingRules(List<EmailMessage> emails){
        //get all the rules and their filters
        //for each email
        ////go through all the rules
        //////for each rule
        ////////instatiate the filter objects
        ///pass the email message through each filter object, keep track of whether all the filter objects
        //pass the criteria
        ////if they do, put the case id on a map, and with a reference to the rule that matched
        //then these will be passed to another class that stamps the cases with the respective field values
        //
        
        /*
         * Get all the rules in the org and their filters
		*/
        List<Email_Routing_Rule__c> allEmailRoutingRules = [SELECT Id ,(SELECT Email_Attribute__c,
                         Operator__c,Value__c FROM Email_Routing_Rule_Filters__r ),
                       (SELECT Business_Unit__c, Case_Type__c FROM Email_Routing_Field_Mappings__r)
                                                            FROM Email_Routing_Rule__c];
        
        /*
         * Go through all the EmailMessage objects
		*/
        for(EmailMessage email : emails){
            
            
            /*A match only occurs when an email message matches ALL the filters
				in a specific rule, so we keep track of this here*/
             Boolean allTheFiltersMatched = false;
            
            /*
             * Check each email against all rules, and break as soon as there's a match
			*/
            for(Email_Routing_Rule__c emailRoutingRule : allEmailRoutingRules){
                
                
                
                /*
                 * Instantiate all the filters for this specific rule
				*/
                for(Email_Routing_Rule_Filter__c filterRecord : emailRoutingRule.Email_Routing_Rule_Filters__r){
                    /*
                     * Instantiate a new EmailRoutingFilter based on this filter record. This object
                     * will provide the logic that is represented in the filter record.
					*/
                    EmailRoutingFilter filter = new EmailRoutingFilter(filterRecord);
                    System.debug('Instantiated the following filter object: '+JSON.serialize(filter));
                    allTheFiltersMatched = filter.compareEmailAttributeAgainstValue(email);
                    System.debug('Result of this specific filter: '+allTheFiltersMatched);
                }
                
                /*
                 * After processing all the filters for this rule, let's see if all the filters matched
                */
                if(allTheFiltersMatched){
                    System.debug('All the filters matched!');
                    /*
                     * if all the filters matched, we keep track of the parent case, and the routing rule
                     * that matched. Because there was a match, we break the loop as we don't need to process
                     * any more rules
					*/
                    rulesThatMatchedPerCaseId.put(email.ParentId,emailRoutingRule);
                    break;
                }
            }
            
        }
        if(rulesThatMatchedPerCaseId.size() > 0){
            System.debug('We have cases that matched rules, so we send them for processing');
            setFieldValuesBasedOnMatchingRules(rulesThatMatchedPerCaseId);
        }
        
    }
    
    private void setFieldValuesBasedOnMatchingRules(Map<Id,Email_Routing_Rule__c> rulesThatMatchedPerCaseId){
        
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.useDefaultRule= true;
        
        List<Case> casesToUpdate = new List<Case>();
        
        List<Case> casesToUpdateFieldsOn = [SELECT Id, Type,Business_Unit__c FROM Case
                                           WHERE Id IN :rulesThatMatchedPerCaseId.keySet()];
            
        
        //go through every case and get the mappings relevant to the rule they matched on
        for(Case caseToUpdate : casesToUpdateFieldsOn){
            Email_Routing_Field_Mapping__c mapping = rulesThatMatchedPerCaseId.get(caseToUpdate.Id).Email_Routing_Field_Mappings__r[0];
            
            caseToUpdate.setOptions(dmlOpts);
            caseToUpdate.Type = mapping.Case_Type__c;
            caseToUpdate.Business_Unit__c = mapping.Business_Unit__c;
            System.debug('This is what the case looks like after adding values: '+JSON.serialize(caseToUpdate));
            casesToUpdate.add(caseToUpdate);
            
        }
        
        if(casesToUpdate.size() > 0){
            System.Debug('Finally, there are cases to update!');
            update casesToUpdate;
        }
        
    }

}