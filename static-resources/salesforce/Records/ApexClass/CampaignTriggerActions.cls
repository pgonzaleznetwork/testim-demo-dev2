public class CampaignTriggerActions extends TriggerFramework.SObjectTriggerActions{
    
    public override void instantiateBeforeInsertActions(){      
        beforeInsertActions.add(new StartDateValidation()); 
    }
    
    public override void instantiateAfterInsertActions(){
        afterInsertActions.add(new DebugAfterInsert());
        afterInsertActions.add(new CreateSharingRecords());
    }
    
    public class StartDateValidation extends TriggerFramework.TriggerAction{
        
        public override void fire(List<SObject> campaigns){
            CampaignService.defaultName((List<SObject>)campaigns);
        }  
    }
    
    public class DebugAfterInsert extends TriggerFramework.TriggerAction{
        public override void fire(map<Id,SObject> newRecords){
            System.debug('after insert');
        }
    }
    
    public class CreateSharingRecords extends TriggerFramework.TriggerAction{
        
        public override void fire(map<Id,SObject> newRecords){
            System.debug('CreateSharingRecords');
        }
    }

}