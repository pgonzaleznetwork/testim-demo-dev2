public class PositiveRuleResult implements RuleResult{
    
    public Lead lead;
    public sObject matchingObject;
    
    public PositiveRuleResult(Lead lead, SObject matchingObject){
        this.lead = lead;
        this.matchingObject = matchingObject;
    }
    
    public Boolean didItMatch(){
        return true;
    }

}