public class ProductCollection extends item{
    
    List<Item> items;
    
    public ProductCollection(){
        items = new List<Item>();
    }
    
    public override Integer getTotalItems(){
        return items.size();
    }
    
    public override void addItem(Item i){
        items.add(i);
    }
    
    public override Double getCost(){
        Double totalCost = 0;
        
        if(items.size() > 0){
            for(Item item : items){
                totalCost = totalCost+item.getCost();
            }
        }
        
        return totalCost;
    }

}