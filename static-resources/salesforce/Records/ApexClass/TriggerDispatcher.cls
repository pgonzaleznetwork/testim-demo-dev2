public class TriggerDispatcher{

  public static void run(ITriggerHandler handler){

    if(handler.isDisabled()){
      return;
    }

    //handle all before logic

    if(Trigger.IsBefore){


      if(Trigger.IsInsert){

        handler.beforeInsert(trigger.new);
      }

      if(Trigger.IsUpdate){
        handler.beforeUpdate(trigger.oldMap,trigger.newMap);
      }

      if(Trigger.IsDelete){
        handler.beforeDelete(trigger.oldMap);
      }


    }

    //handle all after logic

    if(Trigger.isAfter){


      if(Trigger.isInsert){
          
          System.debug('After Insert in Dispatcher!');
          
        handler.afterInsert(trigger.newMap);
      }

      if(Trigger.isUpdate){
        handler.afterUpdate(trigger.oldMap,trigger.newMap);
        
      }

      if(Trigger.IsDelete){
        handler.afterDelete(trigger.oldMap);
      }

      if(Trigger.IsUndelete){
        handler.afterUndelete(trigger.oldMap);
      }

    }
  }
}