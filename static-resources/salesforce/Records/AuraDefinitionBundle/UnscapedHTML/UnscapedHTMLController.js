({
	submitHTML : function(component, event, helper) {
		//find the input field
		var inputValue = component.find("inputField").get("v.value");
        //set the value of the other component
        component.find("htmlValue").set("v.value",inputValue);
	}
})