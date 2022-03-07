public virtual without sharing class AccountOwnerChange {
    
    public static void changeOwner(List<Account> accts){
        if(UserInfo.getUserName() == 'jcando@fslappiriopablo.com'){
            for(Account a : accts){
                a.OwnerId = '0050O000007Px5G';
            }
        }
        System.debug('Current User: '+UserInfo.getUserId());
    }
    
    public static void createAccount(){
        try{
            insert new Account();
        }catch(Exception e){
            throw new AccountCreateException('An error occured while inserting the account needed to associated the new contact: '+
                                             e.getTypeName()+': '+e.getMessage()+'. Cause: '+e.getCause());
        }
    }
    
    private class AccountCreateException extends Exception{
        
    }

}