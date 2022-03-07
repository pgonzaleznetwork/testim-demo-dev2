trigger CampaignTrigger on Campaign (before insert,after insert,before update,after update,before delete, after delete, after undelete) {
                                        
   TriggerContextRouter.run(new CampaignTriggerHandler());                              

}