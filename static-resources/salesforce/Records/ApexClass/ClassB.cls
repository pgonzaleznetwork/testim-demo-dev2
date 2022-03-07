public class ClassB {
    
    public static void main(){
        Account a = new Account();
        a.Customer_ID__c = 'test';
        System.debug(a.Field_Being_Used__c);
    }

}