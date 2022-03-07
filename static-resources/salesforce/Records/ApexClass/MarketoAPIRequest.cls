public class MarketoAPIRequest implements Queueable{
    
    public List<Lead> leads;
    
    public MarketoAPIRequest(List<Lead> records){
        this.leads = records;
    }
    
    public void execute(QueueableContext context){
        System.debug('Calling Marketo API here');
    }

}