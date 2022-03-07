public class LeadObjs {
    
    
    public static void addOwnerAsTeamMember(List<Lead> leads){
        //some logic
    }
    
    public static void updateCurrentProduct(List<Lead> leads){
        
        LeadObjs.CurrentProduct cp = new LeadObjs.CurrentProduct();
        cp.updateCurrentProduct(leads);
       
    }
    
    
    
    
    
    
    
    private class CurrentProduct{
        
        
        public void updateCurrentProduct(List<Lead> leads){
            
            queryAllProducts();
            isProductActive();
        }
        
        private void queryAllProducts(){
            
        }
        
        private Boolean isProductActive(){
            return true;
        }
        
    }
    

}