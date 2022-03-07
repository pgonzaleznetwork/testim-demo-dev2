({
    
    handleSaveRecord : function(component,event,helper){
        component.find("accountRecLoader").saveRecord($A.getCallback(function(saveResult){
            
            if (saveResult.state === "ERROR") {
                var errMsg = "";
                // saveResult.error is an array of errors, 
                // so collect all errors into one message
                for (var i = 0; i < saveResult.error.length; i++) {
                    errMsg += saveResult.error[i].message + "\n";
                }
                component.set("v.recordSaveError", errMsg);
            } else {
                component.set("v.recordSaveError", "");
            }
            
        }));
    }
})