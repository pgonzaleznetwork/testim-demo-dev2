public class LeadDefaultValues {
    
    public static void applyDefaults(List<Lead> leads){
        //implementation
    }
    
    
    
    private class DefaultDeliveryAgency{
        
        List<String> agencies;
        
        public void assignDeliveryAgency(List<Lead> leads){
            queryDeliveryAgencies();
        }
        
        private void queryDeliveryAgencies(){
            
        }
        
    }

}