public class DailyLeadProcessor implements Schedulable{
    
    public void execute(SchedulableContext context){
        
        List<Lead> leadsToUpdate = [SELECT Id,LeadSource FROM Lead WHERE LeadSource = ''];
        
        if(leadsToUpdate.size() > 0){
            
            for(Lead l : leadsToUpdate){
                l.LeadSource = 'Dreamforce';
                
            }
            
            update leadsToUpdate;
        }
        
    }

}