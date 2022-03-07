({
	doInit : function(component, event, helper) {
		var getURLMethod = component.get("c.getURL");
        
        getURLMethod.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
                component.set("v.sfURL",response.getReturnValue());
            }
        });
        
        $A.enqueueAction(getURLMethod);
	}
})