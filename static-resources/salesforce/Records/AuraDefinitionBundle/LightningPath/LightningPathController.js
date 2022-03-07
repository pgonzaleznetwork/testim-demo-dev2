({
	doInit : function(component, event, helper) {
		var apexMethod = component.get("c.getRecordId");
        
        apexMethod.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
                component.set("v.recId",response.getReturnValue());
                console.log("record Id: "+response.getReturnValue());
            }
        });
        
        $A.enqueueAction(apexMethod);
	},
    
    handleSelect : function(component,event,helper){
        //do nothing
    }
})