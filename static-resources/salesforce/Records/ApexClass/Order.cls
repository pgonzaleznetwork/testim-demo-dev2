public class Order {
    
    private List<Item> items;
    
    public Order(List<Item> items){
        this.items = items;
    }
    
    public Double getTotalValueOrder(){
        Double totalValue = 0;
        
        for(Item item : items){
            totalValue = totalValue+item.getCost();
        }
        
        return totalValue;
    }
    
    public Integer getTotalItemsCount(){
        
        Integer totalItemsCount = 0;
        
        for(Item item : items){
            totalItemsCount = totalItemsCount+item.getTotalItems();
        }
        
        return totalItemsCount;
    }

}