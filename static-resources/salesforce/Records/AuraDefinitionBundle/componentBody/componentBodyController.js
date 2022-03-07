({
	showComponentBody : function(component, event, helper) {
        var compBody = component.get("v.body");
        console.log(compBody);
        console.log("This is the component body: "+JSON.stringify(compBody));
	}
})