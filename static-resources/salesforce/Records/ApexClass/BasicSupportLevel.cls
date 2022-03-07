public class BasicSupportLevel implements ISupportLevel{
    
    public Integer getSLA(){
        return 10;
    }
    
    public String getInfo(){
        return 'basic support level info';
    }

}