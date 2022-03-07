public class AddPrimaryContact implements Queueable{
    
    private Contact contact;
    private String stateCode;
    
    public AddPrimaryContact(Contact contact,String stateCode){
        
        this.contact = contact;
        this.stateCode = stateCode;
    }
    
    public void execute(QueueableContext context){
        
        List<Contact> contactsToInsert = new List<Contact>();
        
        for(Account a : [SELECT Id, BillingState 
                         FROM Account WHERE BillingState = :stateCode LIMIT 200]){
                             
                             if(a != null){
                                 Contact newContact = contact.clone(false,false,false,false);
                                 newContact.AccountId = a.Id;
                                 contactsToInsert.add(newContact);
                             }
                             
                         }
        
        if(contactsToInsert.size() > 0){
            insert contactsToInsert;
        }
        
    }
    
}