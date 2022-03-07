public class AccountPaginationController {
    
    public Integer pageSize {get;set;}
    public Integer numberOfRecords {get;set;}
    public List<SelectOption> availablePageSizes {get;set;}
    
    public AccountPaginationController(){
        
        pageSize = 10;
        
        availablePageSizes = new List<SelectOption>();
        availablePageSizes.add(new SelectOption('10','10'));
        availablePageSizes.add(new SelectOption('50','50'));
        availablePageSizes.add(new SelectOption('100','100'));
    }
    
    //instantiate standard set controller
    
    public ApexPages.StandardSetController setController{
        get{
            if(setController == null){
                setController = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Name,
                      Website FROM Account]));
                
                setController.setPageSize(pageSize);
                numberOfRecords = setController.getResultSize();
            }
            return setController;
        }set;
    }
    
    //method to change page size 
    
    public PageReference changePageSize(){
        setController.setPageSize(pageSize);
        return null;
    }
    
    //method to get all accounts from standard set controller
    
    public List<Account> getAccounts(){
        return (List<Account>) setController.getRecords();
    }

}