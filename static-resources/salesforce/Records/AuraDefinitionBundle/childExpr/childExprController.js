({
	updateChildCompAttribute : function(component, event, helper) {
		component.set("v.childCompAttribute","updated child attribute");
        var device = $A.get("$Browser.formFactor");
        console.log("Device info: "+device);
        var locale = $A.get("$Locale.Language");
        console.log("Locale language: "+locale);
	},
    
    onChildCompAttributeChange : function(component,event){
        console.log("childCompAttribute has changed");
        console.log("old value: "+event.getParam ("oldValue"));
        console.log("new value: "+event.getParam ("value"));
    }
})