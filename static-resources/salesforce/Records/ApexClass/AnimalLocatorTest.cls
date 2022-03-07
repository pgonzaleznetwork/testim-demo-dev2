@IsTest
public class AnimalLocatorTest {
    
    public testMethod static void testGetRequestPositive(){
        
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        
        String animalName = AnimalLocator.getAnimalNameById(2);
        
        System.assertEquals(animalName, 'bear');
    }
    
    public testMethod static void testGetRequestNegative(){
        
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMockNegative());
        
        String animalName = AnimalLocator.getAnimalNameById(2);
        
        System.assertEquals(animalName, '{"result":"error"}');
        
    }

}