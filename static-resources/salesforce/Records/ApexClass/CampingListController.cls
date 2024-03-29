public class CampingListController {
    
    @AuraEnabled
    public static List<Camping_Item__c> getItems(){
        return [SELECT Name,Quantity__c,Price__c, Packed__c 
               FROM Camping_Item__C LIMIT 10];
    }
    
    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c item){
        upsert item;
        return item;
    }

}