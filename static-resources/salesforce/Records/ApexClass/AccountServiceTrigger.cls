public class AccountServiceTrigger{


	public static void showAPIUsers(List<Account> accounts){

		APIUtils apiUtil = APIUtils.getInstance();
		List<User> someUsers = apiUtil.getAPIUsers();

		Map<Id,Account> accountsMap = new Map<Id,Account>(accounts);

		List<Contact> contactsToUpdate = new List<Contact>();

		for(Contact c : [SELECT email FROM Contact WHERE AccountId IN :accountsMap.keySet()]){
			c.Email = 'trigger@trigger.com';
			contactsToUpdate.add(c);
		}

		update contactsToUpdate;
	}
}