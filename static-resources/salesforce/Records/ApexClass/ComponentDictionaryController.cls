public class ComponentDictionaryController {
    
    @AuraEnabled
    public static String getURL(){
        String sfURL = URL.getSalesforceBaseUrl().toString();
        return sfURL;
    }

}