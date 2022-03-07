public class FieldValue {
    
    public static List<SObject> fieldHasChanged(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords,String fieldApiName){
        return null;
    }
    
    public static List<SObject> fieldHasNewValue(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords,String fieldApiName,String newValue){
        return null;
    }
    
    public static List<SObject> fieldChangedFromTo(Map<Id,SObject> oldRecords,Map<Id,SObject> newRecords,String fieldApiName,String oldValue,String newValue){
        return null;
    }
    
    
    public static Boolean hasChanged(sObject record,String field){
        
        if(trigger.isBefore && trigger.isInsert){
            
            return (record.get(field) != null);
        }
        
        else if(trigger.isBefore && trigger.isUpdate){
            
            Id recordId = (Id)record.get('Id');
            
            Object currentFieldValue = record.get(field);
            Object oldFieldValue = trigger.oldMap.get(recordId).get(field);
            
            return (oldFieldValue != currentFieldValue);
            
        }
        
        return false;
        
    }
    
    public static Boolean allHaveChanged(sObject record,List<String> fields){
        
        Boolean allValuesChanged;
        
        System.debug('allValuesChanged when instantiated: '+JSON.serialize(allValuesChanged));
        
        if(trigger.isBefore && trigger.isInsert){
              
            for(String field : fields){
                
                System.debug('field being evaluated: '+field);
                
                allValuesChanged = false;
                
                System.debug('allValuesChanged on iteration: '+JSON.serialize(allValuesChanged));
                
                if(record.get(field) != null){
                    System.debug(field+' has changed!: '+JSON.serialize(record.get(field)));
                    allValuesChanged = true;
                    
                    System.debug('allValuesChanged when condition is met: '+JSON.serialize(allValuesChanged));
                }
            }
            
            System.debug('allValuesChanged just before returning: '+JSON.serialize(allValuesChanged));
            
            return allValuesChanged;
        }
        
        else if(trigger.isBefore && trigger.isUpdate){
            
            System.debug('before update here!');
            
            for(String field : fields){
                
                allValuesChanged = false;
                
                Id recordId = (Id)record.get('Id');
            
                Object currentFieldValue = record.get(field);
                Object oldFieldValue = trigger.oldMap.get(recordId).get(field);
                
                if(oldFieldValue != currentFieldValue){
                    allValuesChanged = true;
                }
                
            }
        
        }
        
        return allValuesChanged;
        
    }
    
    public static Boolean anyHasChanged(sObject record,List<String> fields){
        
        return false;
        
    }
    
}