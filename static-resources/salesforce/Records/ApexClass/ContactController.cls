public with sharing class ContactController {
    @AuraEnabled
    public static List<Contact> getContacts() {
        List<Contact> contacts = 
                [SELECT Id, Name, Phone, Email FROM Contact LIMIT 5];
        //Add isAccessible() check
        return contacts;
    }
}