({
	handleClick : function(component, event, helper) {
        
        var newValue = component.get("v.selectedStep");
        
        console.log("selected step previous value: "+newValue);
        
        newValue++;
        
         console.log("selected step new value: "+newValue);
        
        component.set("v.selectedStep",newValue);
        
        var stringvalue = newValue.toString();
         
        component.find("indicator").set("v.currentStep",stringvalue);
		
	}
})