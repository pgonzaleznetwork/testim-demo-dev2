public class OpportunitiesPaginationController{


  public Integer size {get;set;}
  public Integer noOfRecords {get;set;}
  public List<SelectOption> paginationSizeOptions {get;set;}

  public OpportunitiesPaginationController(){

    size = 10;

    paginationSizeOptions = new List<SelectOption>();
    paginationSizeOptions.add(new SelectOption('10','10'));
    paginationSizeOptions.add(new SelectOption('20','20'));
    paginationSizeOptions.add(new SelectOption('50','50'));
    paginationSizeOptions.add(new SelectOption('100','100'));

  }

  public ApexPages.StandardSetController setCon{
    get{
      if(setCon == null){
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id, Name, StageName 
          FROM Opportunity]));

        setCon.setPageSize(10);
        noOfRecords = setCon.getResultSize();

      }

      return setCon;
    }
    set;
  }

  public PageReference refreshPageSize(){
    setCon.setPageSize(size);
    return null;
  }

  public List<Opportunity> getOpportunities(){
    return (List<Opportunity>) setCon.getRecords();
  }


}