public  with sharing class AccountCreator {
    
    public static void createWithRecordType(){
        
        Account a = new Account();
        a.Name = 'My Account';
        a.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Local' AND SobjectType ='Account' LIMIT 1][0].Id;
        a.OwnerId = UserInfo.getUserId();
        
        insert a;
    }
    
    public static void queryAllAccounts(){
        List<Account> accts = [SELECT Id FROM Account];
        System.debug('Current User: '+UserInfo.getUserName()+' Number of Accounts: '+accts.size());
    }

}