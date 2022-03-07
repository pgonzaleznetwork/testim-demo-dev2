@IsTest
public class MainCaseTestClass {
    
    public static testMethod void testCaseCreation(){
        
        Case myCase = CaseTestDataBuilderDirector.createDefaultCase(new CaseTestDataBuilderImpl());
        System.debug(myCase);
        System.assert(myCase.Status == 'Open');
    }
    
    
}