public with sharing class OpportunitiesService {
    
    public static void validateSomeDefatuls(Map<Id,Opportunity> records){
        for(Id id : records.keySet()){
            System.debug('Record id being passed: '+id);
        }
    }
    
    public static void applyDiscounts(Set<Id> opportunityIds,Decimal discountPercentage){
        
        if(opportunityIds==null || opportunityIds.size() == 0){
            throw new OpportunityServiceException('Opportunities not specificied');
        }
        
        if(discountPercentage < 0 || discountPercentage > 100){
            throw new OpportunityServiceException(discountPercentage+ ' is not a valid percentage');
        }
         
        List<Opportunity> opptys = [SELECT Amount,(SELECT UnitPrice FROM OpportunityLineItems) FROM
                                   Opportunity WHERE Id IN :opportunityIds LIMIT :Limits.getLimitQueryRows() - Limits.getQueryRows()];
        
        
        List<Opportunity> opptysToUpdate = new List<Opportunity>();
        List<OpportunityLineItem> opptyLineItemsToUpdate = new List<OpportunityLineItem>();
        Decimal factor = 1 - (discountPercentage==null ? 0 : discountPercentage / 100);
		
        for(Opportunity oppty : opptys){
            
            if(oppty.OpportunityLineItems != null && oppty.OpportunityLineItems.size() > 0){
                
                for(OpportunityLineItem opptyLineItem : oppty.OpportunityLineItems){
                    opptyLineItem.UnitPrice = opptyLineItem.UnitPrice * factor;
                    opptyLineItemsToUpdate.add(opptyLineItem);
                }
            }else{
                oppty.Amount = oppty.Amount * factor;
                opptysToUpdate.add(oppty);
            }
        }
        
        SavePoint sp = Database.setSavepoint();
        
        try{
            if(opptysToUpdate.size() > 0){
                update opptysToUpdate;
            }
            
            if(opptyLineItemsToUpdate.size() > 0){
                update opptyLineItemsToUpdate;
            }
        }catch(Exception e){
            Database.rollback(sp);
            throw e;
        }
        
    }
    
    public static void applyDiscounts(List<ApplyDiscountInfo> discountInfos){
        //
    }
    
    public class OpportunityServiceException extends Exception{}
    
    public class ApplyDiscountInfo{
        
        public Id opportunityId;
        public Decimal discountPercentage;
    }

}