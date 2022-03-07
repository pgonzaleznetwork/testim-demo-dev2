public class SupportLevelFactory {
    
    public static ISupportLevel getInstance(String supportType){
        
        ISupportLevel supportLevel = null;
        
        support_type__c supportTypeSetting = support_type__c.getValues(supportType);
        
        if(supportTypeSetting != null){
            
            Type classType = Type.forName(supportTypeSetting.Class_Name__c);
            
            supportLevel = (ISupportLevel)classType.newInstance();
            return supportLevel;
            
        }else{
             throw new SupportLevelFactoryException('Invalid support type');
        }
                
    }
    
    public class SupportLevelFactoryException extends Exception{}

}