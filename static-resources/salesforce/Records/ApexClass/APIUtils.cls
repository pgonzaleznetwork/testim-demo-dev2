public class APIUtils{

	static APIUtils selfInstance;
    List<User> apiUsers;
    
    public static APIUtils getInstance(){
        
        if(selfInstance == null){
            selfInstance = new APIUtils();
        }
        
        return selfInstance;
    }

	private APIUtils(){

		apiUsers = [SELECT Id FROM User];
        System.debug('SQOL query executed');
	}

	public List<User> getAPIUsers(){
		return apiUsers;
	}

}