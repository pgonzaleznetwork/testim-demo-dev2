public class AccountBeforeInsertActions extends TriggerActionsBase{
    
    public class BlankWebsite extends TriggerContext.BeforeInsert{
        
        public override void fireAction(List<SObject> newRecords){
            AccountService.removeWebsite((List<Account>) newRecords);  
        }
        
        public override void handleException(Exception e){
            //handle it
        }
        
    }
    
    protected override void instantiateBeforeInsertActions(){
        
        beforeInsertActions.add(new BlankWebsite());
        
    }

}