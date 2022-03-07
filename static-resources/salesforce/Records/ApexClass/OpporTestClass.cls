@IsTest
public class OpporTestClass {

    public static testMethod void someTest(){
        OpportunityCreator.createOppty();
        
        //to do: write assert for the above class
        List<Account> accts = [SELECT Name FROM Account];
        
        System.assertEquals( accts[0].Name,'pablo','The name should have been Pablo because of the OpportunityCreator.createOppty() class. Please check that class and see whats wrong');
    }
}