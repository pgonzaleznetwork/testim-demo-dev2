public virtual class TriggerActionsBase {
    
    
    protected List<TriggerActions.BeforeInsertAction> beforeInsertActions;
    protected List<TriggerActions.AfterInsertAction> afterInsertActions;
    
    protected List<TriggerActions.BeforeUpdateAction> beforeUpdateActions;
    protected List<TriggerActions.AfterUpdateAction> afterUpdateActions;
    
    protected List<TriggerActions.BeforeDeleteAction> beforeDeleteActions;
    protected List<TriggerActions.AfterDeleteAction> afterDeleteActions;
    protected List<TriggerActions.AfterUndeleteAction> afterUndeleteActions;
    
    protected Set<String> beforeUpdateActionsExecuted;
    
    public TriggerActionsBase(){
        
        beforeInsertActions = new List<TriggerActions.BeforeInsertAction>();
        afterInsertActions = new List<TriggerActions.AfterInsertAction>();
        beforeUpdateActions = new List<TriggerActions.BeforeUpdateAction>();
        afterUpdateActions = new List<TriggerActions.AfterUpdateAction>();
        beforeDeleteActions = new List<TriggerActions.BeforeDeleteAction>();
        afterDeleteActions = new List<TriggerActions.AfterDeleteAction>();
        afterUndeleteActions = new List<TriggerActions.AfterUndeleteAction>();
        
        beforeUpdateActionsExecuted = new Set<String>();
    }
        
  
    public List<TriggerActions.BeforeInsertAction> getBeforeInsertActions(){

        if(beforeInsertActions.isEmpty()){
            instantiateBeforeInsertActions();
        }
        
        return beforeInsertActions;
        
    }
    
    public List<TriggerActions.AfterInsertAction> getAfterInsertActions(){
        
        if(afterInsertActions.isEmpty()){
            instantiateAfterInsertActions();
        }
        
        return afterInsertActions;
        
    }
    
     public List<TriggerActions.BeforeUpdateAction> getBeforeUpdateActions(){
        
        if(beforeUpdateActions.isEmpty()){
            instantiateBeforeUpdateActions();
        }
        
        return beforeUpdateActions;
        
    }
    
    public List<TriggerActions.AfterUpdateAction> getAfterUpdateActions(){
        
        if(afterUpdateActions.isEmpty()){
            instantiateAfterUpdateActions();
        }
        
        return afterUpdateActions;
        
    }
    
    public List<TriggerActions.BeforeDeleteAction> getBeforeDeleteActions(){
        
        if(beforeDeleteActions.isEmpty()){
            instantiateBeforeDeleteActions();
        }
        
        return beforeDeleteActions;
        
    }
    
    public List<TriggerActions.AfterDeleteAction> getAfterDeleteActions(){
        
        if(afterDeleteActions.isEmpty()){
            instantiateAfterDeleteActions();
        }
        
        return afterDeleteActions;
        
    }
    
     public List<TriggerActions.AfterUndeleteAction> getAfterUndeleteActions(){
        
        if(afterUndeleteActions.isEmpty()){
            instantiateAfterUndeleteActions();
        }
        
        return afterUndeleteActions;
        
    }
    
    
    
    protected virtual void instantiateBeforeInsertActions(){
     
    }
    
    protected virtual void instantiateAfterInsertActions(){
        
    }
    
    protected virtual void instantiateBeforeUpdateActions(){
        
    }
    
    protected virtual void instantiateAfterUpdateActions(){
        
    }
    
    protected virtual void instantiateBeforeDeleteActions(){
        
    }
    
    protected virtual void instantiateAfterDeleteActions(){
        
    }
    
    protected virtual void instantiateAfterUndeleteActions(){
        
    } 
}