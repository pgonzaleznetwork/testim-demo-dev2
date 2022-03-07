public class AnimalLocatorAsyncRequest implements Queueable, Database.AllowsCallouts{
    
    public void execute(QueueableContext context){
        
        System.debug('Async Request Response: '+AnimalLocator.getAnimalNameById(2));
    }

}