/*Contains the logic to:

- Check if the Matching Rule of a given branch returns matching records
- process the If True or If False actions of a dedupe branch

*/
public class DedupeBranchControllerSingle {
    
    /*******************************************************INSTANCE VARIABLES*********************************************************/
    
    private DedupeConfigurationCache configCache;
    private Lead leadToDedupe;
    
    
    /*******************************************************CONSTRUCTOR*********************************************************/
    
    public DedupeBranchControllerSingle(){
        
       
        configCache = DedupeConfigurationCache.getInstance();
        
    }
    
    
    /*******************************************************PUBLIC METHODS*********************************************************/
    
    public void executeDedupeBranch(Dedupe_Branch__c branch,Lead lead){
        
        leadToDedupe = lead;
        
        
        MatchingRuleControllerSingle ruleController = getRelatedMatchingRuleController(branch);
        
         //should do catch/try
        DedupeBranchConfigurationChecker branchConfigChecker = new DedupeBranchConfigurationChecker();
        branchConfigChecker.validateConfiguration(new List<Dedupe_Branch__c>{branch});
        
        
        MatchingRuleControllerSingle.MatchingRuleResult result = ruleController.findMatchingRecords(lead);
        
        if(result.didItMatch){
            executeIfTrueConfiguration(branch,result);
        }else{
            executeIfFalseConfiguration(branch,result);
        }
        
          
    }
    
    /*******************************************************PRIVATE METHODS*********************************************************/
    
    private MatchingRuleControllerSingle getRelatedMatchingRuleController(Dedupe_Branch__c branch){
        
        System.debug('how many times i got here!');
        System.debug('Branch Info: '+JSON.serialize(branch));
        
        Matching_Rule__c matchingRule = configCache.getMatchingRuleByRecordId(branch.Matching_Rule_To_Evaluate__r.Id);
        MatchingRuleControllerSingle matchingRuleController = new MatchingRuleControllerSingle(matchingRule);
        return matchingRuleController;
        
    }
    
    private void executeIfTrueConfiguration(Dedupe_Branch__c branch,MatchingRuleControllerSingle.MatchingRuleResult result){
        
        if(branch.True_Set_This_Field__c != null){
            
            setFieldValuesForIfTrueConfiguration(branch,result.lead);
        }
        
        if(branch.True_Next_Branch__c != null){
            
            Dedupe_Branch__c nextBranch = configCache.getDedupeBranchByRecordId(branch.True_Next_Branch__r.Id);
            
            if(nextBranch.Use_Context_from_Calling_Branch__c){
                executeDedupeBranchWithContext(nextBranch,result);
            }else{
                executeDedupeBranch(nextBranch,result.lead);
            }      
        }
    }
    
    private void executeDedupeBranchWithContext(Dedupe_Branch__c branch, MatchingRuleControllerSingle.MatchingRuleResult context){
        
		MatchingRuleControllerSingle ruleController = getRelatedMatchingRuleController(branch);
        
        MatchingRuleControllerSingle.MatchingRuleResult result = ruleController.findMatchingRecordsWithContext(context);
        
        if(result.didItMatch){
            executeIfTrueConfiguration(branch,result);
        }else{
            executeIfFalseConfiguration(branch,result);
        }        
        
    }
    
    private void setFieldValuesForIfTrueConfiguration(Dedupe_Branch__c branch,Lead lead){
        
        String fieldToSet = branch.True_Set_This_Field__c;
        Object valueToSet = (Object)branch.True_To_This_Value__c;

        SObject leadObj = lead;
        leadObj.put(fieldToSet, valueToSet);
            
    }
    
    
    private void executeIfFalseConfiguration(Dedupe_Branch__c branch,MatchingRuleControllerSingle.MatchingRuleResult result){
        
        
        if(branch.False_Set_This_Field__c != null){
            
           setFieldValuesForIfFalseConfiguration(branch,result.lead);
        }
        
        if(branch.False_Next_Branch__c != null){
            
            Dedupe_Branch__c nextBranch = configCache.getDedupeBranchByRecordId(branch.False_Next_Branch__r.Id);
            
            if(nextBranch.Use_Context_from_Calling_Branch__c){
                executeDedupeBranchWithContext(nextBranch,result);
            }else{
                executeDedupeBranch(nextBranch,result.lead);
            } 
        }
        
    }
    
    private void setFieldValuesForIfFalseConfiguration(Dedupe_Branch__c branch,Lead lead){
        
         String fieldToSet = branch.False_Set_This_Field__c;
         Object valueToSet = (Object)branch.False_To_This_Value__c;
         
         SObject leadObj = lead;
         leadObj.put(fieldToSet, valueToSet);           
    }
    
    /*******************************************************INNER CLASSES*********************************************************/
    
    private class DedupeBranchConfigException extends Exception{}
    
}