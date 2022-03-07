@IsTest
public class CampaignTriggerActionTests {
    
    @IsTest
    public static void when_CampaignsAreInserted_Name_ShouldBe_DefaultName(){
        
        Campaign campaign = new Campaign();
        campaign.Name = 'Not default';
        campaign.StartDate = Date.today();
        
        insert campaign;
        
        Campaign updatedCampaign = [SELECT Name FROM Campaign LIMIT 1];
        
        System.assert(updatedCampaign.Name == 'Default Campaign Name');
        
    }

}