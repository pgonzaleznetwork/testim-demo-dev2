@IsTest
public class StringStack_Test {
    
    /*
	Verifies that push(),pop(), and peak() work correctly
	when there'only 1 object in the stack
	*/
    public static testMethod void basicTest(){
        
        StringStack stack = new StringStack();
        
        //verify the initial state is as expected
        System.assert(stack.isEmpty());
        
        //set up some data
        String onlyString = 'Only String';
        
        //call the push method and verify that the stack is no longer empty
        stack.push(onlyString);
        System.assert(!stack.isEmpty());
        
        //verify that the value we pushed on the stack is the one we expected
        String peakValue = stack.peak();
        System.assertEquals(peakValue, onlyString);
        System.assert(!stack.isEmpty());
        
        //verify that pop works
        String popValue = stack.pop();
        System.assertEquals(popValue, onlyString);
        System.assert(stack.isEmpty());
        
    }

}