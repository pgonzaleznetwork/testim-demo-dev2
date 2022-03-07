public class ArraySorter {
    
    
    public static void bubbleSort(List<Integer> values){
        
        System.debug('Array at start: '+values);
        
        //last ordered index
        Integer loi = values.size();
        
        for(Integer x=0; x < values.size()-1 ; x++){
            
            for(Integer j=0; j <= loi-2; j++){
                if(values[j] > values[j+1]){
                    Integer temp = values[j+1];
                    values[j+1] = values[j];
                    values[j] = temp;
                }
            }
            //reduce the last ordered index after every pass from the outer loop
            loi = loi-1;
        }
        
        System.debug('Array at end: '+values);
    }
    
    public static void bubbleSort2(List<Integer> values){
        
        Integer loi = values.size();
        
        for(Integer x=0 ; x <= values.size()-1 ; x++){
            for(Integer j=0; j <= loi-2 ; j++){
                if(values[j] > values[j+1]){
                    Integer temp = values[j+1];
                    values[j+1] = values[j];
                    values[j] = temp;
                }
                
            }
            loi = loi-1;
        }
        System.debug('Array at end: '+values);
    }
    
}