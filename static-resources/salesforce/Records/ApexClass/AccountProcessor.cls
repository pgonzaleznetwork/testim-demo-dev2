public class AccountProcessor{

	@future
	public static void countContacts(List<Id> accountIds){

		Map<Id,Account> accountsToUpdate = new Map<Id,Account>([SELECT Id,Number_of_Contacts__c ,(SELECT Id 
			FROM Contacts)
			FROM Account WHERE Id  IN : accountIds]);
        
        System.debug('accountsToUpdate inside real class '+accountsToUpdate.values());

		for(Account a : accountsToUpdate.values()){
			a.Number_of_Contacts__c = a.Contacts.size();
		}
        
        List<Database.SaveResult> dmlResults = Database.update(accountsToUpdate.values(),false);
        
        System.debug(dmlResults);
        
        /*try{
            update accountsToUpdate.values();
            if(Test.isRunningTest()){
                throw new DMLException();
            }
        }catch(Exception e){
            System.debug('Error updating accountsToUpdate: '+e);
        }*/
	}
}