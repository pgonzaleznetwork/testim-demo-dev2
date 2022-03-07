/**=====================================================================
 * Name: CaseTriggerHandler
 * Description: [Runs on CaseTrigger implementing all trigger logic]
 * Created Date: [3/2/2015]
 * Created By: Appirio JDC
 * 
 * Date Modified                Modified By                	Description of the update
 * []							[]							[]                
 =====================================================================*/
public without sharing class CaseTriggerHandler {
    
    public static void beforeInsert(List<SObject> newCases){
        
        List<Case> cases = (List<Case>) newCases;
        Case c = cases[0];
        
        System.debug('BEFORE INSERT, WHICH FIELDS ARE AVAILABLE: '+c.Support_Group__c+' - '+c.ear_plug_name__c );
        
    }
    
    public static void afterInsert(List<SObject> newCases){
        
        List<Case> cases = (List<Case>) newCases;
        
         Case c = cases[0];
        
        System.debug('AFTER INSERT, WHICH FIELDS ARE AVAILABLE: '+c.Support_Group__c+' - '+c.ear_plug_name__c );
        
    }
    
    public static void beforeUpdate(List<SObject> newCases){
        
        List<Case> cases = (List<Case>) newCases;
        
         Case c = cases[0];
        
        System.debug('BEFORE UPDATE, WHICH FIELDS ARE AVAILABLE: '+c.Support_Group__c+' - '+c.ear_plug_name__c );
        
    }
    
    public static void afterUpdate(List<SObject> newCases){
        
        List<Case> cases = (List<Case>) newCases;
        
         Case c = cases[0];
        
        System.debug('AFTER UPDATE, WHICH FIELDS ARE AVAILABLE: '+c.Support_Group__c+' - '+c.ear_plug_name__c );
        
    }
}