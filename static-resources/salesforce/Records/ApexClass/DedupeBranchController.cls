/*Contains the logic to:

- Check if the Matching Rule of a given branch returns matching records
- process the If True or If False actions of a dedupe branch

*/
public class DedupeBranchController {
    
    /*******************************************************INSTANCE VARIABLES*********************************************************/
    
    private DedupeConfigurationCache configCache;
    
    
    /*******************************************************CONSTRUCTOR*********************************************************/
    
    public DedupeBranchController(){
        configCache = DedupeConfigurationCache.getInstance();
        
    }
    
    
    /*******************************************************PUBLIC METHODS*********************************************************/
    
    public void executeDedupeBranch(Dedupe_Branch__c branch,List<Lead> leads){
                
        //should do catch/try
        DedupeBranchConfigurationChecker branchConfigChecker = new DedupeBranchConfigurationChecker();
        branchConfigChecker.validateConfiguration(new List<Dedupe_Branch__c>{branch});
        
        MatchingRuleController matchingRuleController = getRelatedMatchingRuleController(branch);
        
        matchingRuleController.findMatchingRecords(leads);
        
        if(!matchingRuleController.getLeadsThatMatched().isEmpty()){
            executeIfTrueConfiguration(branch,matchingRuleController.getLeadsThatMatched());
        }
        
        if(!matchingRuleController.getLeadsThatDidNotMatch().isEmpty()){
            executeIfFalseConfiguration(branch,matchingRuleController.getLeadsThatDidNotMatch());
        }        
    }
    
    /*******************************************************PRIVATE METHODS*********************************************************/
    
    private MatchingRuleController getRelatedMatchingRuleController(Dedupe_Branch__c branch){
        
        Matching_Rule__c matchingRule = configCache.getMatchingRuleByRecordId(branch.Matching_Rule_To_Evaluate__r.Id);
        MatchingRuleController matchingRuleController = new MatchingRuleController(matchingRule);
        return matchingRuleController;
        
    }
    
    private void executeIfTrueConfiguration(Dedupe_Branch__c branch,List<Lead> leads){
        
        if(branch.True_Set_This_Field__c != null){
            
            setFieldValuesForIfTrueConfiguration(branch,leads);
        }
        
        if(branch.True_Next_Branch__c != null){
            
            Dedupe_Branch__c nextBranch = configCache.getDedupeBranchByRecordId(branch.True_Next_Branch__r.Id);
            executeDedupeBranch(nextBranch,leads);
        }
    }
    
    private void setFieldValuesForIfTrueConfiguration(Dedupe_Branch__c branch,List<Lead> leads){
        
        String fieldToSet = branch.True_Set_This_Field__c;
        Object valueToSet = (Object)branch.True_To_This_Value__c;
            
            for(Lead lead : leads){
                SObject leadObj = lead;
                leadObj.put(fieldToSet, valueToSet);
            }
    }
    
    
    private void executeIfFalseConfiguration(Dedupe_Branch__c branch,List<Lead> leads){
        
        
        if(branch.False_Set_This_Field__c != null){
            
           setFieldValuesForIfFalseConfiguration(branch,leads);
        }
        
        if(branch.False_Next_Branch__c != null){
            
            Dedupe_Branch__c nextBranch = configCache.getDedupeBranchByRecordId(branch.False_Next_Branch__r.Id);
            executeDedupeBranch(nextBranch,leads);
        }
        
    }
    
    private void setFieldValuesForIfFalseConfiguration(Dedupe_Branch__c branch,List<Lead> leads){
        
         String fieldToSet = branch.False_Set_This_Field__c;
         Object valueToSet = (Object)branch.False_To_This_Value__c;
            
            for(Lead lead : leads){
                SObject leadObj = lead;
                leadObj.put(fieldToSet, valueToSet);
            }
    }
    
    /*******************************************************INNER CLASSES*********************************************************/
    
    private class DedupeBranchConfigException extends Exception{}
    
}