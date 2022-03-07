({
    handlePassData : function(component, event, helper) {
        var formData = event.getParam("data");
        console.log("Got the data from another component :"+JSON.stringify(formData));
        component.set("v.data",formData);
    },
    
    handlePrevious : function(component, event, helper) {
        
        var showComponent = component.getEvent("showComponent");
        
        showComponent.setParams({"componentName" : 'WizardComponent2Back'});
        
        console.log("firing showComponent event with the following details: WizardComponent1");
        
        showComponent.fire(); 
    },
    
    handleSave : function(component, event, helper) {
        
        //build the objects to insert
        
        var account = {};
        var contact = {};
        var opportunity = {};
        
        var formData = component.get("v.data");
        
        account.Name = formData.AccountName;
        
        console.log("Account to be inserted: "+JSON.stringify(account));
        
        contact.FirstName = formData.FirstName;
        contact.LastName = formData.LastName;
        
        console.log("Contact to be inserted: "+JSON.stringify(contact));
        
        opportunity.Name = formData.opptyName;
        opportunity.StageName = formData.stageName;
        opportunity.CloseDate = formData.closeDate;
        opportunity.Amount = formData.amount;
        
        console.log("Opportunity to be inserted: "+JSON.stringify(opportunity));
        
        var action = component.get("c.saveData");//do to create apex method
        
        action.setParams({
            account:account,
            contact:contact,
            opportunity:opportunity
        });
        
        action.setCallback(this,function(response){
            if(response.getState() == 'SUCCESS'){
                
                var toastEvent = $A.get("e.force:showToast");
                
                if(toastEvent){
                                    toastEvent.setParams({          
                    "title": "Success!",      
                    "message": "The records were saved successfully.",
                                        "type":"success"
                    
                });
                
                toastEvent.fire();
                }else{
                    console.log("success!");
                }
                
                $A.get("e.force:closeQuickAction").fire();

                
            }else if(response.getState() == 'ERROR'){
                
                var error = JSON.stringify(response.getError());  
                
                var toastEventError = $A.get("e.force:showToast");
                
                if(toastEventError){
                                    toastEventError.setParams({                
                    "title": "Fail!",      
                    "message": error,
                                        "type":"error"
                    
                });
                
                toastEventError.fire();
                }else{
                    console.log(error);
                }
                

            }
        });
        
        $A.enqueueAction(action);
    }
})