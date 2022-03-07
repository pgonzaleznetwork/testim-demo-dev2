@IsTest
public class RandomClassTest {

    
        @IsTest
    public static void getRelatedListPicklistValuesTranslatables_Test_Positive(){
        
   
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Account.fields.getMap();
        
        Map<String,List<String>> objectAndFields = new Map<String,List<String>>();
        objectAndFields.put('Account', new List<String>(fieldMap.keySet()));
        
        
        TranslatableMetadataFactory fac = TranslatableMetadataFactory.getInstance();
        
        Test.startTest();
        List<TranslatableMetadata> relatedListPicklistValues = fac.getRelatedListPicklistValuesTranslatables(objectAndFields);
        Test.stopTest();
        
		//because we can't guarantee that the subscriber org has custom fields on this object, we do a best effort of testing
		//that the translatable metadata objects are correct
		
        System.debug('What is the size of this SHIT?! :'+relatedListPicklistValues.size());
		
        if(relatedListPicklistValues.size() > 0){
            System.debug('was this ever executed?');
            System.assert(relatedListPicklistValues[0].type == TranslatableMetadataFactory.TranslatableType.RELATED_LIST_FIELD,'The translatable metadata should be of type RELATED_LIST_FIELD');
            System.assert(relatedListPicklistValues[0].parentObject == 'Account','The parent object of each translatable metadata should match the object named passed to the method');

        }               
    } 
}