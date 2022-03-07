public class PremierSupportLevel  implements ISupportLevel{
    
    public Integer getSLA(){
        return 100;
    }
    
    public String getInfo(){
        return 'Premier Support Info';
    }

}