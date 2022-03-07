public class LeadTriggerActions {
    
    private List<TriggerActions.BeforeInsert> beforeInsertActions;
    private List<TriggerActions.BeforeUpdate> beforeUpdateActions;

    
    public LeadTriggerActions(){
        populateBeforeInsertActions();
        populateBeforeUpdateActions();
    }
        
    private void populateBeforeInsertActions(){
        beforeInsertActions.add(new LeadTriggerActions.ProductCodeInsert());
    }
    
    private void populateBeforeUpdateActions(){
        beforeUpdateActions.add(new LeadTriggerActions.ProductCodeUpdate());
    }
    
    public List<TriggerActions.BeforeInsert> getBeforeInsertActions(){
        return beforeInsertActions;
    }
    
    public List<TriggerActions.BeforeUpdate> getBeforeUpdateActions(){
        return beforeUpdateActions;
    }
    
    /******************************************** BEFORE INSERT ACTIONS *****************************************************************/
    
    public class ProductCodeInsert implements TriggerActions.BeforeInsert{
        
        public void executeAction(List<Lead> leads){
            LeadObjs.updateCurrentProduct(leads);
        }
        
    }
    
    public class DefaultCompanyName implements TriggerActions.BeforeInsert{
        public void executeAction(List<Lead> leads){
            // some logic here -- LeadObjs.updateCurrentProduct(leads);
        }
    }
    
    
    /******************************************** BEFORE UPDATE ACTIONS *****************************************************************/
    
    public class ProductCodeUpdate implements TriggerActions.BeforeUpdate{
        
        private List<Lead> leads;
        
        public void executeIfCriteriaIsMet(Map<Id,SObject> oldLeads,Map<Id,SObject> newLeads){
            
            if(conditionIsMet(oldLeads,newLeads)){
                executeAction();
            }
            
        }
             
        public Boolean conditionIsMet(Map<Id,SObject> oldLeads,Map<Id,SObject> newLeads){
         
            return true;
        }
        
        public void executeAction(){
			LeadObjs.updateCurrentProduct(leads);
        }
     
    }

}