@IsTest
public class ParkLocatorTest {
    
    public testMethod static void testCountry(){
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        //ParkLocator locator = new ParkLocator();
        
        String[] response = ParkLocator.country('India');
        
        System.assertEquals('park1', response[0]);
    }

}