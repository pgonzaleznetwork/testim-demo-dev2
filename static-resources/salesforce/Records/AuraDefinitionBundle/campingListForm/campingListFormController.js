({
	clickCreateItem  : function(component, event, helper) {
        //find all form fields and apply validation
        var validItem = component.find('itemForm').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validItem){

            var newItem = component.get("v.newItem");
            
            helper.createItem(component,newItem);
            
        }
    }
})