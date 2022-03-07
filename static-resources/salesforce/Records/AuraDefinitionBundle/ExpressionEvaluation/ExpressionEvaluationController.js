({
	unlike : function(component, event, helper) {
		component.set("v.liked",false);
	},
    
    like : function(component,event,helper){
        component.set("v.liked",true);
    }
})