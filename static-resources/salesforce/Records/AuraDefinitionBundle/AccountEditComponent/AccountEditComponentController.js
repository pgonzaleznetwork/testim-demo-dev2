({
    
    handleSaveRecord : function(component,event,helper){
        component.find("accountRecordLoader").saveRecord($A.getCallback(function(saveResult){
            console.log(saveResult.state);
        }));
    }
})