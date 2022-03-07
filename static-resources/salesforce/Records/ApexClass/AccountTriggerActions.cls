public class AccountTriggerActions extends TriggerFramework.SObjectTriggerActions {
    
    /********************************************************* ACTIONS BY TRIGGER CONTEXT ****************************************************/
    
    protected override void instantiateBeforeInsertActions(){      
        beforeInsertActions.add(new DefaultWebsite()); 
    }
    
    protected override void instantiateAfterInsertActions(){     
        afterInsertActions.add(new DefaultPrimaryContact());     
    }
    
    protected override void instantiateBeforeUpdateActions(){
        beforeUpdateActions.add(new DefaultWebsite());
        
    }
    
    protected override void instantiateAfterUpdateActions(){
        
    }
    
    protected override void instantiateBeforeDeleteActions(){
        
    }
    
    protected override void instantiateAfterDeleteActions(){
        
    }
    
    protected override void instantiateAfterUndeleteActions(){
        
    }
    
    /********************************************************* ACTION DEFINITIONS ****************************************************/
    
    
    public class DefaultWebsite extends TriggerFramework.TriggerAction{
        
        public override void fire(List<SObject> accounts){
            AccountService.addDefaultWebsite( (List<Account>) accounts);
        }
        
        public override void fire(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords){
            
            Map<Id,Account> oldAccounts = (Map<Id,Account>) oldRecords;
            Map<Id,Account> newAccounts = (Map<Id,Account>) oldRecords;
            List<Account> matchingRecords = new List<Account>();
            
            for(Account acct : oldAccounts.values()){
                if(oldAccounts.get(acct.Id).Website != newAccounts.get(acct.Id).Website){
                    matchingRecords.add(acct);
                }
            }
            
            if(matchingRecords.size() > 0){
                AccountService.addDefaultWebsite(matchingRecords);
            }       
        }    
    }
    
    public class DefaultPrimaryContact extends TriggerFramework.TriggerAction{
        
        public override void fire(Map<Id,SObject> insertedAccounts){
            AccountService.createDefaultPrimaryContact( (List<Account>) insertedAccounts.values() );
        }
    }
    
    
    
    /********************************************************* AFTER INSERT ACTIONS ****************************************************/
    
    
    /********************************************************* BEFORE UPDATE ACTIONS ****************************************************/
    
    
    
    /********************************************************* AFTER UPDATE ACTIONS ****************************************************/
    
    /********************************************************* BEFORE DELETE ACTIONS ****************************************************/
    
    /********************************************************* AFTER DELETE ACTIONS ****************************************************/
    
    /********************************************************* AFTER UNDELETE ACTIONS ****************************************************/
    
    
    
    
    
    
}