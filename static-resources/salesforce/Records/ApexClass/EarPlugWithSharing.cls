public with sharing class EarPlugWithSharing {
    
    public static void seeAllRecords(){
        List<Ear_Plug__c> plugs = [SELECT Id FROM Ear_Plug__c];
        System.debug('Number of plugs accessible to me: '+plugs.size());
    }

}