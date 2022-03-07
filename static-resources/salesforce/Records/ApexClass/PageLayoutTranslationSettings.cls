/*
 * This class provides a method that returns the value of an existing page layout in the org, provided that prior to the installation of
 * this package, a valid page layout name was entered in the Page_Layout_Translation_Manager_Setting__mdt Custom Metadata Type.
 * 
 * This is done because page layouts are visible during apex tests, and it's not possible 
*/
public class PageLayoutTranslationSettings {
    
    public static String getPageLayoutNameForApexTests(){
        
        Page_Layout_Translation_Manager_Setting__mdt setting = [SELECT Page_Layout_Name_in_Tests__c  
               FROM Page_Layout_Translation_Manager_Setting__mdt WHERE 
               QualifiedApiName = 'Default'][0];
        
        
        return setting.Page_Layout_Name_in_Tests__c;
        
    }

}