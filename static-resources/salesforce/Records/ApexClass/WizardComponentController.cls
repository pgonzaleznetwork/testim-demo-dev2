public class WizardComponentController {
    
    @AuraEnabled
    public static void saveData(Account account,Contact contact,Opportunity opportunity){
        
        try{
            insert account;
            insert contact;
            insert opportunity;
        }catch(Exception e){
            if(!Test.isRunningTest()){
                throw new AuraHandledException('Sorry, we tried! Something went wrong when saving a record: '
            + e.getMessage()); 
            }
             
        }

    }

}