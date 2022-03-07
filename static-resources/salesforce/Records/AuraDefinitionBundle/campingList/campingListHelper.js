({
    createItem : function(component,newItem) {
        
        //again, get the method from the apex controller
        var apexMethod = component.get("c.saveItem ");
        
        //set the parameters of the apex method using a json object
        apexMethod.setParams({
            "item":newItem
        });
        
        apexMethod.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                //same pattern as always
                //get the array of items
                var items = component.get("v.items");
                //do some processing
                items.push(response.getReturnValue());
                //set the items array back to notify other components
                component.set("v.items", items);
            }
        });
        $A.enqueueAction(apexMethod);
        
    }
})