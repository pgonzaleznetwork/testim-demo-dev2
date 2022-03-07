public class AllThree {
    
    public static void hi(){
        
        Expense__c e = new Expense__c();
        e.Client__c = 'f';   
        
        if(e.Client__c == 'a'){
            //positive boolean
        }
        else if(e.Client__c != 'b'){
            //negative boolean
        }
    }

}