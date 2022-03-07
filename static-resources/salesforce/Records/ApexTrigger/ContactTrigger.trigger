trigger ContactTrigger on Contact (after update) {

    ContactsServiceTrigger.doSomeProcessing();
}