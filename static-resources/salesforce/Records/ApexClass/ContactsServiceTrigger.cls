public class ContactsServiceTrigger{

	public static void doSomeProcessing(){

		APIUtils apiUtil = APIUtils.getInstance();
		List<User> someUsers = apiUtil.getAPIUsers();

	}
}