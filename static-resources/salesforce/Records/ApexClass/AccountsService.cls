public class AccountsService {
    
    @AuraEnabled
    public static List<Account> getAll(){
        List<Account> results = [SELECT Id, Name, Website FROM Account LIMIT 10];
        return results;
    }

}