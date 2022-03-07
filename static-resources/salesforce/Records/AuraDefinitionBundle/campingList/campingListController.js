({

    doInit : function(component, event, helper){
        
        //get the method from the apex controller using its name. Here "c"
        //referes to the apex controller
        
        var getItemsMethod = component.get("c.getItems");
        
        // Add callback behavior for when response is received
        // from the apex method
        getItemsMethod.setCallback(this, function(response) {
            
            //the common pattern is to check whether the method call was successful, 
            //and decide what to do from there
           
            
            var state = response.getState();
            if (state === "SUCCESS") {
                //if it's successful, add the response of the method to the
                //items array of Camping_Item__c records
                component.set("v.items", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        
        // Send the apex method off to be executed
        $A.enqueueAction(getItemsMethod);
    },
    
    handleAddItem : function(component, event, helper){
        //get payload from the event
        var updatedItem = event.getParam("item");
        helper.createItem(component,updatedItem);
    }
    
})