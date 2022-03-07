public abstract class Item{
    
    public class UnsupportedItemOperationException extends Exception{}
    
    //by default there's only 1 item
    public virtual Integer getTotalItems(){
        return 1;
    }
    
    //depending on whether the child class is a product, or a group of products, the method can be implemented
    public virtual void addItem(item i){
        throw new UnsupportedItemOperationException('addItem not supported for this class');
    }
    
    //all childs must implement this
    public abstract Double getCost();

}