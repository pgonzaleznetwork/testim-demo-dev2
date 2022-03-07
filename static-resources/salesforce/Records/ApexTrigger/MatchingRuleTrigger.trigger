trigger MatchingRuleTrigger on Matching_Rule__c (before insert,before update) {

    MatchingRuleConfigurationChecker configChecker = new MatchingRuleConfigurationChecker();
    configChecker.validateConfig(trigger.new);
    
}