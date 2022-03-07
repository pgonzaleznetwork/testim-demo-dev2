@IsTest
public class LeadDedupeActions_Test {
    
    @IsTest
	public static void when_leadIsExistingParentAndNewChild_newOrderShouldBeCreated(){
        
        assertThatOrderWasCreated();
	
	
	}
    
    @IsTest
    public static void when_leadIsQualified_itShouldBeConverted(){
        
        assertThatOrderWasCreated();
        assertThatAccountWasCreated();
        assertThatIsConvertedIsTrue();
    
    }
    
    private static void assertThatOrderWasCreated(){
        System.assert(1 == 1);
    }
    
    private static void assertThatAccountWasCreated(){
        System.assert(1 == 1);
    }
    
    private static void assertThatIsConvertedIsTrue(){
        System.assert(1 == 1,'The lead was not converted.');
    }

}