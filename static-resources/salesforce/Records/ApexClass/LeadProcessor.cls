global class LeadProcessor implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id,LastName,LeadSource FROM Lead');
    }

    global void execute(Database.BatchableContext bc, List<Lead> records){
        
        List<Lead> leadsToUpdate = new List<Lead>();
        
        for(Lead l : records){
            l.LeadSource = 'Dreamforce';
            leadsToUpdate.add(l);
        }
        
        update leadsToUpdate;
    }    

    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    

}