@IsTest
public class DailyLeadProcessorTest {
    
    @TestSetup
    static void createLeadsForTest(){
        
        List<Lead> leadsToInsert = new List<Lead>();
        
        for(Integer x=0 ; x < 200 ; x++){
            Lead lead = new Lead(FirstName='TestLead'+x,LastName='LastName'+x,Company='TestCompany');
            leadsToInsert.add(lead);
        }
        
        insert leadsToInsert;
    }
    
    public testMethod static void testExecuteMethod(){
        
        //there should be 200 leads with no source
        List<Lead> leadsWithNoSource = [SELECT Id FROM Lead WHERE LeadSource = ''];
        System.assertEquals(200,leadsWithNoSource.size());
        
        //Schedule the job to update the source
        String CRON_EXP = '0 0 0 15 3 ? 2022';
        
        Test.startTest();
        
        System.schedule('whatever', CRON_EXP, new DailyLeadProcessor());
        
        Test.stopTest();
        
        //there should be 0 leads with no source
        leadsWithNoSource = [SELECT Id FROM Lead WHERE LeadSource = ''];
        System.assertEquals(0,leadsWithNoSource.size());
        
        //there should be 200 leads with a source
        List<Lead> leadsSource = [SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200,leadsSource.size());
        

    }

}