public class UpdateParentAccount implements Queueable{
    
    private List<Account> accounts;
    private Id parent;
    
    public UpdateParentAccount(List<Account> records, Id id){
        this.accounts = records;
        this.parent = id;
    }
    
    public void execute(QueueableContext context){
        for(Account acct : accounts){
            acct.parentId = parent;
        }
        
        update accounts;
    }

}