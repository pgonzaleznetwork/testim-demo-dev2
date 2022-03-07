public with sharing class EnhancedLeadConversion {

    LeadConversionConfig config;
    
    public EnhancedLeadConversion(LeadConversionConfig config){
        this.config = config;
    }

    public void doConvert(){

        List<String> queryFields = config.getQueryFields();
        System.debug('executing soql with the following fields '+queryFields);

        if(config.getConversionType() === LeadConversionConfig.ConversionType.INTERNAL){
            System.debug('executing default internal conversion');
        }

        if(config.shouldConvertAsync(100)){
            System.debug('converting async');
        }else{
            System.debug('converting sync');
        }

    }

}