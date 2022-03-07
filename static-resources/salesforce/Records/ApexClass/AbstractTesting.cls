public class AbstractTesting extends TriggerActions.AfterUpdateAB{
    
    public override void executeIfCriteriaIsMet(){
        //
    }
    
    
    protected override void executeAction(){
        leads = new List<Lead>();
    }
    
    protected override Boolean conditionIsMet(){
        return true;
    }

}