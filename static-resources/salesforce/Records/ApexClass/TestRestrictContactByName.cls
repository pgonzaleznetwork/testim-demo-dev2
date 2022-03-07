@IsTest
public class TestRestrictContactByName {
    
    public testMethod static void testBeforeInsert(){
        
        Test.startTest();
        
		createSampleContacts('INVALIDNAME');
        
        Test.stopTest();
        
        List<Contact> insertedContacts = [SELECT LastName,Id FROM
                                          Contact WHERE LastName = 'INVALIDNAME'];
        
        System.assertEquals(insertedContacts.size(), 0);
        
    }
    
    public testMethod static void testBeforeUpdate(){
        
        createSampleContacts('RandomLastName');
        
        List<Contact> contactsToUpdate = [SELECT Id,LastName FROM
                                         Contact WHERE LastName = 'RandomLastName'];
        
        for(Contact c : contactsToUpdate){
            c.LastName = 'INVALIDNAME';
        }
        
        try{
            update contactsToUpdate;
        }catch(Exception e){
            System.debug(e);
        }
        
        List<Contact> updatedContacts = [SELECT LastName,Id FROM
                                          Contact WHERE LastName = 'INVALIDNAME'];
        
        System.assertEquals(updatedContacts.size(), 0);
    }
    
    private static void createSampleContacts(String lastName){
        
        List<Contact> contactsToInsert = new List<Contact>();
        
        for(Integer x=0;x<201;x++){
            Contact c = new Contact(LastName=lastName);
            contactsToInsert.add(c);
        }
        
        try{
            insert contactsToInsert;
        }catch(Exception e){
            System.debug(e);
        }
        
    }
    
}