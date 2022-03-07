public class LeadTriggerHandler implements ITriggerHandler {
    
    private LeadTriggerHandler.FilterCondition filterCondition;
    
    private List<TriggerActions.BeforeUpdate> beforeUpdateActions;
    private List<TriggerActions.BeforeInsert> beforeInsertActions;
    private LeadTriggerActions triggerActions;
    
    private static final Integer MAX_BEFORE_UPDATE_EXECUTIONS = 1;
    private static Integer BEFORE_UPDATE_EXECUTIONS_SO_FAR = 0;
    
    
    public LeadTriggerHandler(){
        
        
        triggerActions = new LeadTriggerActions();
        
        //filterCondition = new LeadTriggerHandler.FilterCondition();
        
        beforeInsertActions = triggerActions.getBeforeInsertActions();
        beforeUpdateActions = triggerActions.getBeforeUpdateActions();
        
    }
    
    
    public void beforeInsert(List<SObject> newLeads){
        
        for(TriggerActions.BeforeInsert action : beforeInsertActions){
            action.executeAction(newLeads);
        }
        
    }
    
    public void beforeUpdate(Map<Id,SObject> newLeads,Map<Id,SObject> oldLeads){
        
        BEFORE_UPDATE_EXECUTIONS_SO_FAR++;
        
        if(beforeUpdateExecutionsIsMoreThanMax()){
            //do nothing because we don't want more recursive trigger calls
        }else{
            if(!beforeUpdateActions.isEmpty()){
                
                for(TriggerActions.BeforeUpdate action : beforeUpdateActions){
                    if(action.conditionIsMet(oldLeads, newLeads)){
                        action.executeAction();
                    }
                }
                
            }
        }
        
        
        
        
        
        /*if(filterCondition.productCodeWasUpdated(newLeads,oldLeads)){
LeadObjs.updateCurrentProduct(filterCondition.filteredLeads);
}

if(filterCondition.statusChangedToQualified(newLeads,oldLeads)){
LeadObjs.addOwnerAsTeamMember(filterCondition.filteredLeads);
}*/
        
        
        
    }
    
    private Boolean beforeUpdateExecutionsIsMoreThanMax(){
        
        return BEFORE_UPDATE_EXECUTIONS_SO_FAR > MAX_BEFORE_UPDATE_EXECUTIONS;
        
    }
    
    public void beforeDelete(Map<Id,SObject> oldLeads){
        
    }
    
    public void afterInsert(Map<Id,SObject> newLeads){
        
        
        LeadValidation.validate(newLeads.values());
        
    }
    
    public void afterUpdate(Map<Id,SObject> newLeads,Map<Id,SObject> oldLeads){
        
        LeadValidation.validate(newLeads.values());
        
        if(filterCondition.requiresConversionIsTrue(newLeads,oldLeads)){
            LeadService.convertLeads(filterCondition.filteredLeads);
        }
        
    }
    
    public void afterDelete(Map<Id,SObject> oldLeads){
        
    }
    
    public void afterUndelete(Map<Id,SObject> oldLeads){
        
    }
    
    public Boolean isDisabled(){
        return false;
    }
    
    
    
    
    
    public class FilterCondition{
        
        List<Lead> filteredLeads;
        
        public filterCondition(){
            filteredLeads = new List<Lead>();
        }
        
        public boolean productCodeWasUpdated(Map<Id,SObject> newLeads,Map<Id,SObject> oldLeads){
            
            filteredLeads.clear();        
            
            return true;
        }
        
        public boolean statusChangedToQualified(Map<Id,SObject> newLeads,Map<Id,SObject> oldLeads){
            
            filteredLeads.clear();
            
            return true;
        }
        
        public boolean requiresConversionIsTrue(Map<Id,SObject> newLeads,Map<Id,SObject> oldLeads){
            
            filteredLeads.clear();
            
            return true;
        }
        
    }
    
}