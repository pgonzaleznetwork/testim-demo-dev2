@IsTest
public with sharing class EnhancedLeadConversion_Tests {

    @IsTest 
    public static void testDefaultConversion(){

        LeadConversionConfig config = getConfig();
        EnhancedLeadConversion conversion = new EnhancedLeadConversion(config);

        conversion.doConvert();


        

    }

    private static LeadConversionConfig getConfig(){

        List<String> fieldsToQuery = new List<String>{'field1','field2'};

        Amoss_Instance configController = new Amoss_Instance( LeadConversionConfig.class );
        configController
            .when()
                .method( 'getQueryFields' )
                .willReturn(fieldsToQuery )
            .also().when()
                .method( 'getConversionType' )
                .willReturn( LeadConversionConfig.ConversionType.INTERNAL )
            .also().when()
                .method( 'shouldConvertAsync' )
                .withParameter(50)
                .willReturn( true )
            .also().when()
                .method( 'shouldConvertAsync' )
                .withParameter(100)
                .willReturn( false );

        LeadConversionConfig config = (LeadConversionConfig)configController.generateDouble();

        return config;
    }
    
}