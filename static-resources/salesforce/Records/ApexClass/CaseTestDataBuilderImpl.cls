@isTest
public class CaseTestDataBuilderImpl implements ICaseTestDataBuilder{
    
    private Case c;
    private Contact con;
    private Account acct;

    public Case createCase(){
        
        c = new Case();
        c.Subject = 'Test Case';
        c.Description = 'Test Description';
        c.Status = 'Open';
        c.ContactId = con.Id;
        c.AccountId = acct.Id;
            
        try{
            insert c;
            return c;
        }catch(Exception e){
            //do nothing;
            return null;
        }	      
        
    }
    
    public void createAccount(){
        
        acct = new Account(Name='Test Account');
        
        try{
            insert acct;
        }catch(Exception e){
            //nothing
        }
        
    }
    
    public void createContact(){
        
        con = new Contact();
        con.FirstName = 'TestContact';
        con.LastName = 'TestContactLastName';
        con.AccountId = acct.Id;
        
        try{
            insert c;
        }catch(Exception e){
            //do nothing
        }
        
    }

}