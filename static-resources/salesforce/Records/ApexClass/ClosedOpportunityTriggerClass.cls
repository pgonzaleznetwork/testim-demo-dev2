public class ClosedOpportunityTriggerClass {
    
    public static void createTaskOnClosedWon(List<Opportunity> opptys){
        
        List<Task> newTasks = new List<Task>();
        
        for(Opportunity o : opptys){
            if(o.StageName == 'Closed Won'){
                Task newTask = new Task();
                newTask.subject = 'Follow Up Test Task';
                newTask.WhatId = o.Id;
                newTasks.add(newTask);
            }
        }
        
        if(!newTasks.isEmpty() || newTasks.size() > 0){
            try{
                insert newTasks;
            }catch(Exception e){
                //do nothing
            }
        }
        
    }

}