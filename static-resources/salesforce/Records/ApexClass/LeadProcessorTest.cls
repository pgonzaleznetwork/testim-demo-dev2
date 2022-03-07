@IsTest
public class LeadProcessorTest {
    
    @testSetup
    static void createLeadData(){
        List<Lead> leads = new List<Lead>();
        
        for(Integer x=0;x<200;x++){
            Lead l = new Lead(LastName='LastName'+x);
            l.Company = 'Appirio';
            leads.add(l);
        }
        
        insert leads;
    }
    
    public testMethod static void testBatch(){
        
        Test.startTest();
        Database.executeBatch(new LeadProcessor());
        Test.stopTest();
        
        System.assertEquals(200, [SELECT COUNT() FROM Lead
                                 WHERE LeadSource = 'Dreamforce']);
    }

}