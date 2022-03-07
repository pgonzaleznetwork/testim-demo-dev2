@IsTest
/*
 * @Author: Pablo Gonzalez - 2018
 * Provides positive and negative tests for the SubmitPageLayoutInfoApex apex class.
*/
public class SubmitPageLayoutInfoApex_Test {
    
    
    public static testMethod void testRequestTranslationFile_Positive(){
                
        Test.startTest();
        SubmitPageLayoutInfo_LEX_Controller.getTranslationKeysFromThisPageLayout('Account-Account Layout');
        Test.stopTest();
        
        
    }
    
    public static testMethod void testRequestTranslationFile_Negative(){
        
        Test.startTest();
        try{
            SubmitPageLayoutInfo_LEX_Controller.getTranslationKeysFromThisPageLayout('TestInvalidName');
         }catch(Exception e){
            System.assert(e != null,'An invalid layout name should have thrown an exception. Review the logs for the PageLayoutTranslationInfoV2 class.');
        }
        Test.stopTest();
        
    }
}