@IsTest
public class AlgorithmsTests {
    
    @IsTest
    public static void testFindLargestInteger(){
        
        List<Integer> integers = new List<Integer>{7,4,2,8,1,9};        
        System.assert(Algorithms.findLargestInteger(integers) == 9);
        
    }

    @IsTest
    public static void testLinearSearchOrderedArray(){


    	List<Integer> orderedArray = new List<Integer>{1,3,5,7,9,12,45,67,89};


    	System.assert(Algorithms.linearSearchOrderedArray(orderedArray,9) == 4);
    	System.assert(Algorithms.linearSearchOrderedArray(orderedArray,19) == null);

    }

    @IsTest
    public static void testBinarySearch(){


    	List<Integer> orderedArray = new List<Integer>{1,3,5,7,9,12,45,67,89};

    	System.assert(Algorithms.binarySearch(orderedArray,67) == 7);
    	System.assert(Algorithms.binarySearch(orderedArray,19) == null);

    }
    
    @IsTest
    public static void testIsPrime(){
        
        System.assert(Algorithms.isPrime(2));
        System.assert(Algorithms.isPrime(8) == false);
        
    }
    
    @IsTest
    public static void testBubbleSort(){
        
        List<Integer> unsortedArray = new List<Integer>{4,3,6,8,5,1,4,2};
        List<Integer> sortedArray = Algorithms.bubbleSort(unsortedArray);
        
        System.debug('Sorted Array: '+sortedArray);
        
        System.assert(sortedArray[0] == 1);
        System.assert(sortedArray[7] == 8);
        
    }
    
    @IsTest
    public static void testSelectionSort(){
        
         List<Integer> unsortedArray = new List<Integer>{4,3,6,8};
        List<Integer> sortedArray = Algorithms.selectionSort(unsortedArray);
        
        System.debug('Sorted Array: '+sortedArray);
        
        System.assert(sortedArray[0] == 3);
        System.assert(sortedArray[3] == 8);
        
    }

}