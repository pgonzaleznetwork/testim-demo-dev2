public class VietnamLeadDeduplicator {
    
    private List<LeadInfo> leadsInfo;
    private String leadField1;
    private String leadField2;

    
    public class DedupeException extends Exception{
        
    }
    
    public VietnamLeadDeduplicator(){
        
        //get field api names via custom metadata type
        List<VietLeadDedupeSetting__mdt> dedupeSettings = [SELECT Field1ApiName__c, Field2ApiName__c  FROM VietLeadDedupeSetting__mdt LIMIT 1];
        
        if(dedupeSettings.isEmpty()){
            throw new DedupeException('No custom metadata available');
        }
        
        leadField1 = dedupeSettings[0].Field1ApiName__c;
        leadField2 = dedupeSettings[0].Field2ApiName__c;   
        leadsInfo = new List<LeadInfo>();
        
    }
    

    
    public void dedupeLeads(List<Lead> leads){
        
        List<Lead> leadsToCreate = new List<Lead>();
        
        //these lists need to be aware of the fields we are matching by, they cannot be hardcoded
        
        //Get a list of all the mobile numbers that we need to query for duplicates
        List<String> leadField1Values = new List<String>();
        //Get a list of all Last Names that we need to query for duplicates
        List<String> leadField2Values = new List<String>();
        
        for(Lead lead : leads){
            
            //populate lists -- we would have to have an idea of the different parameters that need to be
            //populated
            leadField1Values.add(lead.LastName);
            System.debug('leadField1Values: '+leadField1Values);
            leadField2Values.add(lead.MobilePhone);
            System.debug('leadField2Values: '+leadField2Values);
            //create lead info object
            LeadInfo li = new LeadInfo(lead.LastName,lead.MobilePhone);
            leadsInfo.add(li);
            
        }
        
        String soqlQuery = 'SELECT Id,'+leadField1+','+leadField2+' FROM Lead WHERE '+leadField1+' IN :leadField1Values '+
            'AND '+leadField2+' IN :leadField2Values';
        
        System.debug('SOQL Query: '+soqlQuery);
        
        List<sObject> existingLeads = Database.query(soqlQuery);
        System.debug('Existing Leads: '+existingLeads);
        
        //query existing leads using all the lastnames and mobilephones
        /*List<Lead> existingLeads = [SELECT Id,LastName,MobilePhone FROM Lead
                                   WHERE LastName IN:lastNames AND MobilePhone IN:mobilePhones];*/
        
        //go through every existing lead that match
        
        for(sObject leadObj : existingLeads){
            Lead existingLead = (Lead)leadObj;
            //and match against a specific leadInfo object
            for(LeadInfo leadInfo : leadsInfo){
                if(leadInfo.lastName == existingLead.LastName && leadInfo.mobilePhone == existingLead.MobilePhone){
                   //if there's a match, set these variables
                    leadInfo.match = true;
                    leadInfo.matchingLead = existingLead;
                    leadInfo.matchReason = 'LNP';
                }
            }
        }
        
        for(LeadInfo leadInfo : leadsInfo){
            //if there wasn't a match, check again by last name only
            if(!leadInfo.match){
                for(sObject leadObj : existingLeads){
                    Lead existingLead = (Lead)leadObj;
                    if(leadInfo.lastName == existingLead.LastName){
                        leadInfo.match = true;
                        leadInfo.matchingLead = existingLead;
                        leadInfo.matchReason = 'LN';
                    }
                }
            }
        }
        
         System.debug(leadsInfo);
        
        
        
        /*for(LeadInfo leadInfo : leadsInfo){
            if(!leadInfo.match){
                Lead l = new Lead(LastName=leadInfo.lastName,MobilePhone=leadInfo.mobilePhone,Company='demo');
                leadsToCreate.add(l);
            }
        }*/
        
        if(leadsToCreate.size() > 0){
            insert leadsToCreate;
        }
        
    }
    
        public class LeadInfo{
        
        String lastName;
        String mobilePhone;
        String dedupeStatus;
        Boolean match;
        String matchReason;
        Lead matchingLead;
        
        LeadInfo(String lastName,String mobilePhone){
            this.lastName = lastName;
            this.mobilePhone = mobilePhone;
            dedupeStatus = null;
            match = false;
            matchReason = null;
                
        }
        
    }
    

}