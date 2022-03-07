public class SingleProduct extends Item{
    
    private Double cost;
    private String name;
    
    public SingleProduct(Double cost,String name){
        this.cost = cost;
        this.name = name;
    }
    
    public override Double getCost(){
        return cost;
    }

}