public class PageLayoutTranslationInfo {
    
    private String layoutName;
    private String objectName;
    private String layoutOnlyName;
    private List<String> layoutSectionsList;
    private List<String> fields;
    private List<String> allStandardFields;
    private List<String> standardFieldsHelp; //StandardFieldHelp.Account.AccountNumber.HelpText
    private List<String> allSObjects;
    private Map<String,Schema.DescribeSObjectResult> allObjectsMap;
    private Map<String,String> standardPicklistValues;
    private List<String> customPicklistValues;
    private List<String> picklistValues = new List<String>();
    
    //new implementation
    private List<FieldInformation> customFields;
    private List<FieldInformation> standardSfFields;
    
    public PageLayoutTranslationInfo(String layoutName){
        this.layoutName = layoutName;
        List<String> parts = layoutName.split('-');
        this.objectName = parts[0];
        this.layoutOnlyName = parts[1];
        layoutSectionsList = new List<String>();
        fields = new List<String>();
        standardFieldsHelp = new List<String>();
        standardPicklistValues = new Map<String,String>();
        customPicklistValues = new List<String>();
        allObjectsMap = new Map<String,Schema.DescribeSObjectResult>();
        
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
            Schema.DescribeSObjectResult describeResult  = objTyp.getDescribe();
            String name =  describeResult.getName();
            allObjectsMap.put(name, describeResult);
            
            //allSObjects.add(name);
        }
    }
    
    public void buildTables(){
        
        Savepoint sp = Database.setSavepoint();
        
        Layout_Translation_Info__c layoutInfoRecord = new Layout_Translation_Info__c(Name=layoutName);
        insert layoutInfoRecord;
        
        List<Layout_Section_Translation_Name__c> layoutSectionRecords = new List<Layout_Section_Translation_Name__c>();
        
        List<String> allSections = getLayoutSections();
        
        for(String section : allSections){
            Layout_Section_Translation_Name__c sectionRecord = new Layout_Section_Translation_Name__c();
            sectionRecord.Name = section;
            sectionRecord.Layout_Translation_Info__c = layoutInfoRecord.Id;
            layoutSectionRecords.add(sectionRecord);
        }
        
        try{
            insert layoutSectionRecords;
        }catch(Exception e){
            Database.rollback(sp);
        }
        
        List<Field_Translation_Name__c> fieldRecords = new List<Field_Translation_Name__c>();
        List<String> allFields = getFields();
        
        for(String field : allFields){
            Field_Translation_Name__c fieldRecord = new Field_Translation_Name__c();
            fieldRecord.Name = field;
            fieldRecord.Layout_Translation_Info__c = layoutInfoRecord.Id;
            fieldRecords.add(fieldRecord);
        }
        
        try{
            insert fieldRecords;
        }catch(Exception e){
            Database.rollback(sp);
        }
        
        List<Standard_Field_Help__c > fieldHelpRecords = new List<Standard_Field_Help__c>();
        standardFieldsHelp = getStandardFieldsHelp();
        
        for(String help : standardFieldsHelp){
            Standard_Field_Help__c helpRecord = new Standard_Field_Help__c();
            helpRecord.Name = help;
            helpRecord.Layout_Translation_Info__c = layoutInfoRecord.Id;
            fieldHelpRecords.add(helpRecord);
        }
        
        try{
            insert fieldHelpRecords;
        }catch(Exception e){
            Database.rollback(sp);
        }
        
        List<Picklist_Value__c> picklistValueRecords = new List<Picklist_Value__c >();
        for(String value : picklistValues){
            Picklist_Value__c plVal = new Picklist_Value__c(name=value);
            plVal.Layout_Translation_Info__c = layoutInfoRecord.Id;
            picklistValueRecords.add(plVal);
        }
        
         try{
            insert picklistValueRecords;
        }catch(Exception e){
            Database.rollback(sp);
        }
        
        
    }
    
    private List<String> getStandardFieldsHelp(){
        
        List<String> fieldsHelp = new List<String>();
        //StandardFieldHelp.Account.AccountNumber.HelpText
        for(String standardField : allStandardFields){
            String fieldHelp = 'StandardFieldHelp.'+objectName+'.'+standardField+'.HelpText';
            fieldsHelp.add(fieldHelp);
        }
        return fieldsHelp;
    }
    
    private List<String> getLayoutSections(){
        
        
        List<Metadata.Metadata> layouts = Metadata.Operations.retrieve(Metadata.MetadataType.Layout, new List<String> {layoutName});
        Metadata.Layout layoutMd = (Metadata.Layout) layouts.get(0);
        
        List<Metadata.LayoutSection> layoutSections = layoutMd.layoutSections;
        
        for (Metadata.LayoutSection section : layoutSections) {
            
            String sectionName = 'LayoutSection.'+objectName+'.'+layoutOnlyName+'.'+section.label;
            
            layoutSectionsList.add(sectionName);
            
        }
        
        return layoutSectionsList;
    }
    
    private List<String> getFields(){
        
        List<String> standardFields = new List<String>();
        
        List<Metadata.Metadata> layouts = Metadata.Operations.retrieve(Metadata.MetadataType.Layout, new List<String> {layoutName});
        Metadata.Layout layoutMd = (Metadata.Layout) layouts.get(0);
        
        List<Metadata.LayoutSection> layoutSections = layoutMd.layoutSections;
        
        
        for(Metadata.LayoutSection section : layoutSections){
            List<Metadata.LayoutColumn> columns = section.layoutColumns;
            
            
            for(Metadata.LayoutColumn column : columns){
                
                if(column.layoutItems != null){
                    List<Metadata.LayoutItem> layoutItems = column.layoutItems;
                    
                    for(Metadata.LayoutItem item : layoutItems){
                        
                        
                        
                        if(item.field != null){
                            
                            //fieldsInfo.add(item.field);
                            //then call get metadata with fields info
                            
                            String fieldTranslationApiName;
                            
                            
                            // CustomField.Energy_Audit__c.Annual_Energy_Usage_kWh.HelpText
                            
                            if(item.field.contains('__c')){
                                
                                
                                
                                
                                fieldTranslationApiName = item.field.substringBefore('__c');
                                String fieldLabel = 'CustomField.'+objectName+'.'+fieldTranslationApiName+'.FieldLabel';
                                String fieldHelpText = 'CustomField.'+objectName+'.'+fieldTranslationApiName+'.HelpText';
                                
                                fields.add(fieldLabel);
                                fields.add(fieldHelpText);
                            }else{
                                standardFields.add(item.field);
                                
                            }
                            
                            List<String> everySingleField = new List<String>();
                            everySingleField.add(item.field);
                            getFieldMetadata(objectName,everySingleField);
                            
                            
                            
                        }
                        
                        
                    }
                    
                }   
            }
        }
        System.debug(fields);
        allStandardFields = standardFields;
        return fields;
        
    }
    
    public void getFieldMetadata(String objectName,List<String> fields){
        
        Schema.DescribeSObjectResult objectDescribe = allObjectsMap.get(objectName);
        Map<String, Schema.SObjectField> objectFields = objectDescribe.fields.getMap();
        
        for(String field : fields){
            if(objectFields.containsKey(field)){
                
                Schema.DescribeFieldResult fieldDescribe = objectFields.get(field).getDescribe();
                //for custom picklist Fields
                if(fieldDescribe.getType() == Schema.DisplayType.PICKLIST && fieldDescribe.isCustom()){
                    String fieldTranslationName  = field.substringBefore('__c');
                    List<Schema.PicklistEntry> values = fieldDescribe.getPicklistValues();
                    
                    for(Schema.PicklistEntry value : values){
                        //PicklistValue.Account.SLA.Bronze
                        String customPicklistVal = 'PicklistValue.'+objectName+'.'+fieldTranslationName+'.'+value.getLabel();
                        picklistValues.add(customPicklistVal);
                    }
                }
                //for standard picklist fields
                if(fieldDescribe.getType() == Schema.DisplayType.PICKLIST && !fieldDescribe.isCustom()){
                    List<Schema.PicklistEntry> values = fieldDescribe.getPicklistValues();
                    
                    for(Schema.PicklistEntry value : values){
                        //PicklistValue.Standard.accountOwnership.Subsidiary
                        String standardPicklistVal = 'PicklistValue.Standard'+'.'+field+'.'+value.getLabel();
                        
                        picklistValues.add(standardPicklistVal);
                    }
                }
                
                //for any custom field
                if(fieldDescribe.isCustom()){
                    
                FieldInformation fieldInfo = new FieldInformation();
                fieldInfo.name = field.substringBefore('__c');
                fieldInfo.masterLabel = fieldDescribe.getLabel();
                fieldInfo.helpText = fieldDescribe.getInlineHelpText();
                fieldInfo.labelKey = 'CustomField.'+objectName+'.'+fieldInfo.name+'.FieldLabel';
                fieldInfo.helpTextKey = 'CustomField.'+objectName+'.'+fieldInfo.name+'.HelpText';
                 
                 
                    
                }
                
            }
        }
        
    }
    
    private class FieldInformation{
        
        public String name;
        public String masterLabel;
        public String helpText;
        public String labelKey;
        public String helpTextKey;
        
    }
    
}