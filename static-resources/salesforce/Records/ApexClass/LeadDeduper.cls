public class LeadDeduper {
    
    public void dedupeLeads(List<Lead> leads){
        
        DedupeConfigurationCache dedupeCache = DedupeConfigurationCache.getInstance();
        
        DedupeBranchControllerSingle primaryBranch = new DedupeBranchControllerSingle();
        
        primaryBranch.executeDedupeBranch(dedupeCache.getDedupeBranchByRecordId('a0d0O00000CLPWF'), leads[0]);
    }

}