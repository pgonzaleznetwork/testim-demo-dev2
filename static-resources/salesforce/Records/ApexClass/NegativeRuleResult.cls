public class NegativeRuleResult implements RuleResult{
    
    public NegativeRuleResult(Lead lead){
        this.lead = lead;
    }
    
    public Lead lead;
    
    public Boolean didItMatch(){
        return false;
    }

}