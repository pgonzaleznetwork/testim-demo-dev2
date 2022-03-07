public class AccountCustomError {
    
    public static void putError(List<Account> newAccounts){
        
		Account a = newAccounts[0];

        try{
            a.addError('Can this be caught??');
        }catch(Exception e){
            System.debug('This was caught! '+e.getMessage());
        }        
        
    }
    
    

}