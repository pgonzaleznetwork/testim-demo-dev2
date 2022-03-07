public with sharing class LeadConversionConfig {

    Lead lead;
    public enum ConversionType {PARTNER, CUSTOMER, INTERNAL}


    public LeadConversionConfig(Lead lead) {
        this.lead = lead;
    }

    public List<String> getQueryFields(){
        return new List<String>{'FirstName,CustomField__c,Status'};
    }

    public ConversionType getConversionType(){
        if(lead.FirstName == 'partner'){
            return ConversionType.PARTNER;
        }
        return ConversionType.INTERNAL;
    }

    public Boolean shouldConvertAsync(Integer queriesUsed){
        if(queriesUsed > 90){
            return true;
        }
        return false;
    }
}