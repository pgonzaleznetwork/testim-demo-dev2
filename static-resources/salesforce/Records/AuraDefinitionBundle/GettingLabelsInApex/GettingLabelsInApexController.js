({
	doInit : function(component, event, helper) {
		var apexMethod = component.get("c.getLabelValue");
        apexMethod.setCallback(this,function(response){
            console.log(response.getState());
            if(response.getState() === "SUCCESS"){
                console.log("success");
                component.set("v.myLabel",response.getReturnValue());
            }
        });
        
        $A.enqueueAction(apexMethod);
	}
})