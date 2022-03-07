public class StringStack {

    private List<String> stack;

    private Integer lastItemIndex{
        get{
            return stack.size()-1;
        }
    }

    public String getStackName(){
        return 'This is a stack';
    }

    public StringStack(){
        stack = new List<String>();
    }

    public void push(String s){
        stack.add(s);
    }

    public String pop(){
        return stack.remove(lastItemIndex);
    }

    public String peak(){
        return stack.get(lastItemIndex);
    }

    public Boolean isEmpty(){
        return stack.isEmpty();
    }

}