public with sharing class LightningController {
    
    @AuraEnabled
    public static List<Account> getActiveAccounts(){
        
        List<String> accountFields = new List<String>{'Id,Name,Website'};
            
        Map<String,Schema.SObjectField> accountFieldMap = Schema.SObjectType.Account.fields.getMap();
        
        for(String fieldName : accountFields){
            if(!accountFieldMap.get(fieldName).getDescribe().isAccessible()){
                throw new System.NoAccessException();
            }
        }
        List<Account> accounts = [SELECT Id,Name,Website FROM Account];
        return accounts;
    }

}