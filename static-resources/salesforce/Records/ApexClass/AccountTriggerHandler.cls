public class AccountTriggerHandler {
    
    public static void afterUpdate(Map<Id,Account> oldRecords,Map<Id,Account> newRecords){
        distributeTotal(oldRecords,newRecords);
    }
    
    /*
     * Distributes the value of the total__c field among all related contacts
	*/
    @TestVisible
    private static void distributeTotal(Map<Id,Account> oldRecords,Map<Id,Account> newRecords){
        
        Set<Id> accountIdsNewTotal = new Set<Id>();
        
        for(Account newAccount : newRecords.values()){
            
            Account oldAccount = oldRecords.get(newAccount.Id);
            
            Boolean totalHasChanged = (oldAccount.Total__c != newAccount.Total__c);
            
            if(totalHasChanged){
                accountIdsNewTotal.add(newAccount.Id);
            }
        }
        
        if(!accountIdsNewTotal.isEmpty()){
                      
            List<Contact> contactsToUpdate = new List<Contact>();
            
            //here we could have just queried the contacts separetely and store them in a map by their account id, but since the inner
            //query provides the same functionality, it's ok to query the account data again (even if it was already available via the trigger context).
            
            List<Account> accountsAndContacts = [SELECT Id,Total__c,(SELECT Id,Share__c FROM Contacts) FROM Account WHERE Id IN :accountIdsNewTotal];
            
            for(Account account : accountsAndContacts){
                              
                if(!account.contacts.isEmpty()){
                                       
                    Integer numOfContacts = account.contacts.size();
                    Boolean zeroOrNull = (account.Total__c == null || account.Total__c == 0);
                    
                    System.debug('is the value zero or null: '+zeroOrNull);
                    
                    //we only calculate the share if the total is a positive or negative value, otherwise we default
                    //to null
                    
                    Decimal share = null;
                    
                    if(!zeroOrNull){
                        share = account.Total__c / numOfContacts;
                    }
                    
                    for(Contact contact : account.contacts){
                        contact.Share__c = share;
                        contactsToUpdate.add(contact);
                    }          
                }        
            }
            
            if(!contactsToUpdate.isEmpty()){
                update contactsToUpdate;
                //could also be Database.update(contactsToUpdate,false) if we were ok with partial updates
            }             
        }
    }
}