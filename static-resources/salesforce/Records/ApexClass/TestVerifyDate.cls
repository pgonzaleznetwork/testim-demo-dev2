@IsTest
public class TestVerifyDate {
    
    public testMethod static void testPositiveCheckDates(){
        
        Date date1 = Date.newInstance(2017, 11, 10);
        Date date2 = Date.newInstance(2017, 11, 20);
        
        VerifyDate.CheckDates(date1, date2);
        
        
    }
    
    public testMethod static void testNegativeCheckDates(){
        
        Date date1 = Date.newInstance(2017, 11, 10);
        Date date2 = Date.newInstance(2016, 11, 14);
        
        VerifyDate.CheckDates(date1, date2);
    }
    
}