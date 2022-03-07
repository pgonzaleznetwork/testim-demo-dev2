public class LeadServiceRouter {
    
    public static void routeLeads(Map<Id,Lead> newLeads,Map<Id,Lead> oldLeads){
        
        if(leadsNeedsConvertion(newLeads.values())){
            LeadService.convertLeads(newLeads.values());
        }
        
        //more routers
        
    }
    
    
    private static Boolean leadsNeedsConvertion(List<Lead> leads){
        //check trigger.oldMap vs trigger.newMap to see if it meets the criteria for convertion
        //
        return true;
    }

}