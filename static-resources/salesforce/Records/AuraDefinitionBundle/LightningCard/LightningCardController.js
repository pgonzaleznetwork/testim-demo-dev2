({
	doInit : function(component, event, helper) {
		var apexMethod = component.get("c.getAll");
        
        apexMethod.setCallback(this,function(response){
            if(response.getState() == "SUCCESS"){
                component.set("v.accounts",response.getReturnValue());
            }
        });
        
        $A.enqueueAction(apexMethod);
	}
})