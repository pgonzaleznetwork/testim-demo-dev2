public class RandomContactFactory {
    
    public static List<Contact> generateRandomContacts(Integer numberOfContacts,String lastName){
        
        List<Contact> contactsToReturn = new List<Contact>();
        
        for(Integer x=0;x<numberOfContacts;x++){
            
            Contact c = new Contact();
            c.FirstName = lastName+String.valueOf(x);
            c.LastName = lastName;
            contactsToReturn.add(c);
        }
        
        return contactsToReturn;
    }

}