public class MyContactListController {
    
    @AuraEnabled
    public static List<Contact> getContacts(Id recordId){
        return [SELECT Id,FirstName,LastName,Phone FROM Contact
               WHERE AccountId = :recordId];
    }

}