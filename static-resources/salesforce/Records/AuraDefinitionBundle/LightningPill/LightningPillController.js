({
	handleRemove : function(component, event, helper) {
		var name = event.getSource().get("v.name");
        if(name == "np"){
            component.set("v.shownp",false);
        }else if(name == "pl"){
            component.set("v.showpl",false);
        }
	}
})