({
	handlePassData : function(component, event, helper) {
		var formData = event.getParam("data");
        console.log("Got the data from another component :"+JSON.stringify(formData));
        console.log("Setting local data attribute");
        component.set("v.data",formData);
	},
    
    handleNext : function(component, event, helper) {
        
        //get the data object and add more values
        
        var formData = {};
        
        formData = component.get("v.data");
        
        var opptyName = component.find("opptyName").get("v.value");
        var stageName = component.find("stageName").get("v.value");
        var closeDate = component.find("closeDate").get("v.value");
        var amount = component.find("amount").get("v.value");
        
        formData.opptyName = opptyName;
        formData.stageName = stageName;
        formData.closeDate = closeDate;
        formData.amount = amount;
        
        //populate the application event with the object 
        
        var dataEvent = $A.get("e.c:passData");
      
        dataEvent.setParams({
            "data":formData
        });
        
        console.log("firing passData event with the following details: "+JSON.stringify(formData));
        
        dataEvent.fire();
        
        //fire event to let parent component know which child component to show
        
        var showComponent = component.getEvent("showComponent");
        
        showComponent.setParams({"componentName" : 'WizardComponent3Next'});
        
        console.log("firing showComponent event with the following details: WizardComponent3");
        
        showComponent.fire(); 
    },
    
    handlePrevious : function(component, event, helper) {
        
        var showComponent = component.getEvent("showComponent");
        
        showComponent.setParams({"componentName" : 'WizardComponent1Back'});
        
        console.log("firing showComponent event with the following details: WizardComponent1");
        
        showComponent.fire(); 
    }
})