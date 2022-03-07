({
	handleChange : function(component, event, helper) {
		console.log(event.getSource());

	},
    
    showSelected : function(component,event,helper){
        console.log("Selected values: "+component.find("myBox").get("v.value"));
    }
})