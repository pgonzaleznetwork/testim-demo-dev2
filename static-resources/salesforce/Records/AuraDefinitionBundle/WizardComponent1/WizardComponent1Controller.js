({
	handleNext : function(component, event, helper) {
        
        //get values from input fields
        
        var accountName = component.find("accountName").get("v.value");
        var contactFirstName = component.find("firstName").get("v.value");
        var contactLastName = component.find("lastName").get("v.value");
        
        //create an object with the input field data
        
        var formData = {};
        
        formData.AccountName = accountName;
        formData.FirstName = contactFirstName;
        formData.LastName = contactLastName;
        
       //populate the application event with the object 
        
        var dataEvent = $A.get("e.c:passData");
      
        dataEvent.setParams({
            "data":formData
        });
        
        //fire the event
        
        console.log("firing passData event with the following details: "+JSON.stringify(formData));
        
        dataEvent.fire();
        
        //fire event to let parent component know which child component to show
        
        var showComponent = component.getEvent("showComponent");
        
        showComponent.setParams({"componentName" : 'WizardComponent2Next' });
        
        console.log("firing showComponent event with the following details: WizardComponent2");
        
        showComponent.fire(); 
        
        
       
	}
})