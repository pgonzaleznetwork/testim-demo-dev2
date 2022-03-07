public class Algorithms {
    
    /********************************** OVERVIEW ****************************************************/
    
    /*
* When talking about how fast an operation takes, we are not talking about time,
* but *how many steps* it takes. This is because hardware contraints will affect performance.
*
* Measuring the number of steps of an operation is known as its *time complexity*.
*/
    
    /********************************** READING ****************************************************/
    
    /*
* Reading always takes one step, because of the following reasons:
* - When an array is created, the computer allocates certain slots in memory
* - The computer knowns the starting slot
* - The computer can go to any slot in one step
* - When asking for the value in a particular index, the computer looks at the starting slot in memory
* and adds X to it, to find the memory slot of the required index.
*
* It's considered a very efficient operation because it always takes one step.
*/
    
    public static void readFromArray(List<String> values){
        String value = values[4];
    }
    
    /********************************** SEARCHING ****************************************************/
    
    /*
* Searching is looking for a particular value in the array and what index it is at.
* A search where the computer needs to look at each index at a time is called LINEAR SEARCH
* 
* A linear search in an array of 5 values will take a max of 5 steps (if the searched value is the last one).
* Likewise, if the array has 5000 values, it will take a max of 5000 steps.
*
* In other words, for N cells, Linear Search will take a max of N steps.
*/  
    
    public static Integer findLargestInteger(List<Integer> integers){
        
        Integer max = integers[0]; // < read operation on the array
        
        /*
* This is O(N) because there could be as many steps as there are elements in the array.
*/
        
        for(Integer x=1; x < integers.size(); x++){
            //go through every value until we find the max, worst case is we don't find it or it's the last
            if(integers[x] > max){
                max = integers[x];
            }
        }
        
        return max;
    }
    
    /********************************** INSERTING ****************************************************/
    
    /*
* Inserting at the end of the array only takes one step.
* Inserting in the middle or the beginning, requires all the elements to move one
* index to the right, to make room for the new element.
*
* The worst case scenario is where we insert at the beginning of the array, which
* would take N+1 steps. N steps for moving all existing elements to the right, and
* 1 step to insert the new value.
*/ 
    
    /********************************** DELETION ****************************************************/
    
    /*
* Deleting at the end of the array only takes one step.
* This would require all remaining elements to be moved to the left, to close the empty gap.
*
* This means for an array of 5 elements, deleting the first one takes 5 steps.
* 1 step deleting the element, and 4 steps moving the remaining ones to the left.
*
* Worst case for deleting is N steps for an array of N elements. 
*/ 
    
    /********************************** SETS ****************************************************/
    
    /*
* Sets are like arrays but don't accept duplicate values.
* 
* The best case scenario for inserting into a set, is where we insert at the end of it.
* However, the set needs to go through all the existing elements to make sure that the 
* new one doesn't already exist, so this would take:
*
* N steps for searching + 1 step for inserting.
*
* The worst case scenario is inserting at the beginning, because we have to:
* - Search all elements (N steps)
* - Move all elements one index to the right (N steps)
* - Insert the new element
*
* 2N+1 steps
*/
    
    public static void setVSArray(){
        
        Set<String> uniqueIds = new Set<String>();
        uniqueIds.add('ANY element'); //needs to search all existing values
        
        List<String> ids = new List<String>();
        ids.add('ANY element'); // no need to search through the array
        
    }
    
    /********************************** ORDERED ARRAYS / BINARY SEARCH ****************************************************/
    
    public static Integer linearSearchOrderedArray(List<Integer> orderedArray,Integer value){
        
        for(Integer i=0; i < orderedArray.size(); i++){
            if(orderedArray[i] == value){
                return i;
            }
            else if(orderedArray[i] > value){//if the current value is greater than the searched value
                //and we didn't find it in the above if condition, we exist and return null
                //because we know the value could not possibly be anywhere else in the array
                break;
            }
        }
        return null;
    }
    
    /*
* The biggest advantage of sorted arrays is that they allow for binary search,
* which is much much efficient than linear search.
*/  
    
    public static Integer binarySearch(List<Integer> orderedArray,Integer value){
        
        Integer lowerBound = 0; //the index of the lowest value
        Integer higherBound = orderedArray.size()-1; //the index of the highest value
        
        while(lowerBound <= higherBound){
            //keep running until the lower and higher bounds meet each other
            
            System.debug('lowerBound :'+lowerBound);
            System.debug('higherBound: '+higherBound);
            
            Integer midPoint = (lowerBound+higherBound)/2; //divide the array into 2 to get the index
            //in the middle
            
            System.debug('midPoint: '+midPoint);
            
            //i.e: lowerBound 0 + higherBound 9 >> 9  then 9/2: 4.5 mid index
            
            // next iteration where half to the right was discarded
            // lowerBound 0 + highBound 3 > >> 3  then 3/2: 1.2 mid index
            
            // alternative iteration where half to the left was discarded
            // lowerBound 5 + higherBound 5 >> 10 then 10/2 : 5 mid index
            
            /*
DEBUG|lowerBound :0
DEBUG|higherBound: 8
DEBUG|midPoint: 4
DEBUG|valueAtMidpoint: 9
DEBUG|lowerBound :5
DEBUG|higherBound: 8
DEBUG|midPoint: 6
DEBUG|valueAtMidpoint: 45
*/
            
            Integer valueAtMidpoint = orderedArray[midPoint];
            
            System.debug('valueAtMidpoint: '+valueAtMidpoint);
            
            if(value == valueAtMidpoint){//best case scenario where the value equals the searched one
                return midPoint;
            }
            else if(value < valueAtMidpoint){
                //we can discard everything to the right (and including) the midpoint, since
                //we know the array is ordered
                higherBound = midPoint-1;
            }
            else if(value > valueAtMidpoint){
                //we can discard everything to the left and including the midpoint
                lowerBound = midpoint+1;
            }
        }
        return null;
        
    }
    
    /*
* Every time we double the amount of elements in the array, binary search just adds ONE additional step.
* Linear search would, in contrast, double the amount of steps.
*
* That is because with every pass, binary search half the elements in the array. 
*/ 
    
    /********************************** BIG O NOTATION ****************************************************/
    
    /*
* It describes how many steps an algo takes based on the number of data elements that it is acting upon
*
* O(1) "Oh of 1" : The algorithm takes the same number of steps no matter how much data there is (not necessrily one step).
* O(N) "Oh of N": for an array of N elements, it would take N steps to complete, i.e linear search
* O(N) is also known as Linear Time and O(1) is known as Constant Time
*
* O(1) is more efficient than any O(N) algo. At some point O(N) will reach the same number of steps as
* O(1) and from that point up to infinity, O(N) will take more steps.
*
* Big O generally represents the worst-case scenario. 
*/
    
    /********************************** LOGARITHMS ****************************************************/
    
    /*
* Binary search adds only one step more for every time the data is doubled. This is known as
* O(log N) -- this is known as complexity time of log time.
*
* O(log N) is a way of describing an algortihm that adds one step each time the data is doubled.
*
* A logarithm is the opposite of an exponent. An exponent is the following:
*
* 3 x 3 = 6 ------ which is the same as saying 3² = 6
* ² means that the number below is multiplied by itself that many times.
*
*   
* log² 8 is 3, again, 2 needs to multiply itself 3 times to become 8.
* 
* So this is read as follows: How many times does the small number need to multiply itself
* to become the next number?
* 
* Another way of explaining this is: How many times do we need to halve (divide by 2)
* number 8 until it becomes 1?
* 
* 8/2: 4
* 4/2: 2
* 2/2: 1
* 
* 3 times. So log 2 of 8 is 3. 
* 
* O (log N) actually stands for O (log2 N), the 2 is removed for convenience.
* This means that for N elements, the algorithm will taken log2 N steps to complete.
* 
* If there are 16 elements, the algortihm will take log2 16, which is:
* 
* 16/2: 8
* 8/2: 4
* 4/2: 2
* 2/1: 1
* 
* 4 steps.
* 
* Another way would be to ask, how many times does 2 need to multiply itself to become 16?
* 
* 2*2: 4
* 4*2: 8
* 8*2: 16
* 
* There are four 2s in total.  
* 
* Simply said: O (log2 N) means that the algorithm takes as many steps as it takes
* to keep halving the data lements until we remain with one. 
* 
*/
    
    /*Here's a classic example of an O(N) algorithm.
* 
* Even though there isn't an array, the worst number of steps is the amount of numbers
* betweenn 2 and num, so the higher the value of num is, the more steps the algorithm
* will take.
* 
* A number is prime if it's exactly divisible by any natural number other than
* 1 and itself. For example, 7 can only be divided by 7 and 1, so it's prime.
* 
* 8 can be divided by 8, 4, 2 and 1, so it's not prime.
*/
    
    public static Boolean isPrime(Integer num){
        
        for(Integer x=2; x < num ; x++){
            if(Math.mod(num, x) == 0){
                return false;
            }
        }       
        return true;      
    }
    
    /****************************************QUADRATIC TIME******************************/
    
    /*
     * Bubble sort has an effiency of O(N*N) >> N to the power of 2, or N square.
     * 
     * As the number of elements increase, the number of steps increase by N square.
     * 
     * For example, for 5 elements, we need 20 steps (5 square is 25)
     * For 20 elements, we need 380 steps (20 square is 400)
     * 
     * This is considered a relatively inefficient algorithm.
	*/
    
    public static List<Integer> bubbleSort(List<Integer> nums){
        
        Integer lastUnsortedIndex = nums.size();
        Integer value;
        Integer nextValue;
        Boolean sorted = false;
        
        while(!sorted){
            
            for(Integer x=0; x < lastUnsortedIndex-1; x++){
                
                sorted = true;
                value = x;
                nextValue = x+1;
                
                if(nums[value] > nums[nextValue]){
                    sorted = false;
                    Integer temp = nums[value];
                    nums[value] = nums[nextValue];
                    nums[nextValue] = temp;       
                } 
            }
            lastUnsortedIndex--;
        }
        
        return nums;
    }
    
    /*
     * O(N square) is the typical effiency of nested for loops, as for each outer loop iteration,
     * we need to iterate through the entire inner loop.  
	*/
    
    /*SELECTION SORT*/
    
    public static List<Integer> selectionSort(List<Integer> nums){
        
        for(Integer i=0; i < nums.size() ; i++){
            
            System.Debug('outer for loop index: '+i);
            
            //we start with the assumption that the first index is the lowest
            Integer lowestIndex = i;
            //we also start with the assumption that there isn't another number that is lowest
            Boolean swapRequired = false;
            
            for(Integer x=i+1; x < nums.size(); x++){
                
                System.Debug('inner for loop index: '+x);
                
                //if the current number is lower than the lowest so far
                if(nums[x] < nums[lowestIndex]){
                    lowestIndex = x;//we say that the lowestIndex is the new one
                    swapRequired = true;//and we keep track of the fact that we need to swap them
                }  
            }
            
            //swap if required
            if(swapRequired){
                Integer temp = nums[i];
                nums[i] = nums[lowestIndex];
                nums[lowestIndex] = temp;
            }
            
        }
        
        
        return nums;
            
    }
    
    public List<Integer> insertionSort(List<Integer> nums){
        
        for(Integer i=1; i < nums.size(); i++){
            
            Integer temp = nums[i];
            
            for(Integer x=i; x >= 0 ; x--){
                
            }
            
        }
        
        return null;
    }
    
}