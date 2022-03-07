({
	doInit : function(component, event, helper) {
		var breadcrumbList = [
            {label: 'Account',name: 'objectName'},
            {label: 'Record Name',name:'record'}
        ]
        
        component.set("v.breadcrumbList",breadcrumbList);
        
        console.log("doInit was called");
	},
    
    navigateTo : function(component,event,helper){
        var name = event.getSource().get("v.name");
        alert("You clicked on: "+name);
    }
})