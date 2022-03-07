public class BinarySearch {
    
    public static Integer doSearch(List<Integer> data,Integer searchValue){
        
        if(data.isEmpty()){
            throw new BinarySearchException('No elements found in the array');
        }
        
        Integer lb = 0;
        Integer ub = data.size()-1;
        Integer mp;
        
        while(lb <= ub){
            mp = (lb+ub)/2;

            if(data[mp] > searchValue){
                ub = mp-1;
            }else if(data[mp] < searchValue){
                lb = mp+1;
            }else if(data[mp]==searchValue){
                return mp;
            }
        }
        return -1;
        
    }
    private class BinarySearchException extends Exception{}
}