/*Holds all the records required to dedupe a lead.
This is done so that we don't need to query all the records once per lead, instead we query them once
and we make them available in memory*/

public class DedupeConfigurationCache {
    
    /*******************************************************INSTANCE VARIABLES*********************************************************/
    
    private Map<String,Dedupe_Scenario__c> dedupeScenariosByCountry;
    private Map<Id,List<Dedupe_Branch__c>> dedupeBranchesByScenarioId;
    private Map<Id,Matching_Rule__c> matchingRuleByRecordId;
    private Map<Id,Dedupe_Branch__c> dedupeBranchByRecordId;
    private static DedupeConfigurationCache instance;
    
    
    /*******************************************************CONSTRUCTOR*********************************************************/
    
    private DedupeConfigurationCache(){
        instantiateMemberVariables();
        queryAndMapDedupeScenarios();
        queryAndMapDedupeBranches();
        queryAndMapMatchingRules();
        
    }
    
    /*******************************************************PUBLIC METHODS*********************************************************/
    
    public static DedupeConfigurationCache getInstance(){
        if(instance == null){
            instance = new DedupeConfigurationCache();
        }
        return instance;
    }
    
    public Dedupe_Scenario__c getDedupeScenarioByCountry(String countryName){
        
        Dedupe_Scenario__c dedupeScenario = dedupeScenariosByCountry.get(countryName);
        if(dedupeScenario == null){
            throw new DedupeScenarioNotFoundException('There isnt a dedupe scenario defined for '+countryName);
        }else{
            return dedupeScenario;
        }
        
    }
    
    public List<Dedupe_Branch__c> getDedupeBranchesByScenarioId(Id scenarioId){
        
        List<Dedupe_Branch__c> dedupeBranchList = dedupeBranchesByScenarioId.get(scenarioId);
        return dedupeBranchList;
    }
    
    public Dedupe_Branch__c getDedupeBranchByRecordId(Id recordId){
                
        Dedupe_Branch__c dedupeBranch = dedupeBranchByRecordId.get(recordId);
        
        if(dedupeBranch == null){
            throw new DedupeBranchNotFoundException('The record id '+recordId+' does not match an existing Dedupe_Branch__c');
        }else{
            return dedupeBranch;
        }
        
    }
    
    public Matching_Rule__c getMatchingRuleByRecordId(Id recordId){
        
        Matching_Rule__c matchingRule = matchingRuleByRecordId.get(recordId);
        
        if(matchingRule == null){
            throw new MatchingRuleNotFoundException('The record id '+recordId+' does not match an existing Matching_Rule__c');
        }else{
            return matchingRule;
        }
    }
    
    /********************************************************PRIVATE METHODS*********************************************************/
    
    private void instantiateMemberVariables(){
        dedupeScenariosByCountry = new Map<String,Dedupe_Scenario__c>();
        dedupeBranchesByScenarioId = new Map<Id,List<Dedupe_Branch__c>>();
        matchingRuleByRecordId = new Map<Id,Matching_Rule__c>();
        dedupeBranchByRecordId = new Map<Id,Dedupe_Branch__c>();
    }
    
    private void queryAndMapDedupeScenarios(){
        
        List<Dedupe_Scenario__c> allDedupeScenarioRecords = [SELECT Id,Country__c,Name FROM Dedupe_Scenario__c];
        
        for(Dedupe_Scenario__c dedupeScenarioRecord : allDedupeScenarioRecords){
            
            createListOfBranchesPerScenario(dedupeScenarioRecord);
            dedupeScenariosByCountry.put(dedupeScenarioRecord.Country__c,dedupeScenarioRecord);
            
        }
    }
    
    private void createListOfBranchesPerScenario(Dedupe_Scenario__c dedupeScenarioRecord){
        dedupeBranchesByScenarioId.put(dedupeScenarioRecord.Id,new List<Dedupe_Branch__c>());
    }
    
    
    private void queryAndMapDedupeBranches(){
        
        List<Dedupe_Branch__c> allDedupeBranchRecords = [SELECT Id,Use_Context_from_Calling_Branch__c ,Starting_Point__c,False_Set_This_Field__c,False_To_This_Value__c,
        True_Set_This_Field__c,True_To_This_Value__c,Dedupe_Scenario__r.Id, Matching_Rule_To_Evaluate__r.Id,
        False_Next_Branch__r.Id,True_Next_Branch__r.Id FROM Dedupe_Branch__c];
        
        for(Dedupe_Branch__c dedupeBranchRecord : allDedupeBranchRecords){
            
            mapBranchesByScenarioId(dedupeBranchRecord);
            dedupeBranchByRecordId(dedupeBranchRecord);
            
            
        }
    }
    
    private void mapBranchesByScenarioId(Dedupe_Branch__c dedupeBranchRecord){
        List<Dedupe_Branch__c> dedupeBranchesList = dedupeBranchesByScenarioId.get(dedupeBranchRecord.Dedupe_Scenario__r.Id);
        dedupeBranchesList.add(dedupeBranchRecord);
    }
    
    private void dedupeBranchByRecordId(Dedupe_Branch__c dedupeBranchRecord){
        dedupeBranchByRecordId.put(dedupeBranchRecord.Id,dedupeBranchRecord);
    }
    
    private void queryAndMapMatchingRules(){
        
        List<Matching_Rule__c> allMatchingRuleRecords = [SELECT Id,Lead_Evaluated_Field__c,Matching_Field__c ,Matching_Object__c,
        Type__c,Type_of_Contact_to_Match__c FROM Matching_Rule__c];
        
        for(Matching_Rule__c matchingRuleRecord : allMatchingRuleRecords){
            
            matchingRuleByRecordId.put(matchingRuleRecord.Id, matchingRuleRecord);
            
        }
    }
    
    /*******************************************************INNER CLASSES*********************************************************/
    
    private class DedupeScenarioNotFoundException extends Exception{}
    private class MatchingRuleNotFoundException extends Exception{}
    private class DedupeBranchNotFoundException extends Exception{}

}