public class AccountService {
    
    public static void addDefaultWebsite(List<Account> accounts){
        for(Account acct : accounts){
            acct.website = 'www.awesometrigger.com';
        }
    }
    
    public static void addDefaultNumberOfEmployees(List<Account> accounts){
        for(Account a : accounts){
            a.numberOfEmployees = 100;
        }
    }
    
    public static void createDefaultPrimaryContact(List<Account> accounts){
        
        List<Contact> primaryContacts = new List<Contact>();
        
        for(Account acct : accounts){
            if(acct.Id == null){
                throw new AccountServiceException('You cannot create a contact for an account that has not been inserted.');
            }
            
            Contact primaryContact = new Contact();
            primaryContact.AccountId = acct.Id;
            primaryContact.FirstName = 'Default';
            primaryContact.LastName = 'Primary';
            primaryContacts.add(primaryContact);
        }
        
        if(primaryContacts.size() > 0){
            
            Database.insert(primaryContacts, false);
        }
        
    }
    
    public class AccountServiceException extends Exception{}
    
}