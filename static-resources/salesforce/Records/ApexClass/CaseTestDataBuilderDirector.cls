@IsTest
public class CaseTestDataBuilderDirector {
    
    public static Case createDefaultCase(ICaseTestDataBuilder builder){
        builder.createAccount();
        builder.createContact();
        return builder.createCase();
    }

}