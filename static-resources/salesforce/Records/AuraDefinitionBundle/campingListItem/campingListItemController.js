({
	packItem : function(component, event, helper) {
        //get the item attribute from the component
        var itemAttribute = component.get("v.item");
        //because it's an sObject, I can access field values directly
        itemAttribute.Packed__c = true;
        //since we've changed something in the sObject attribute
        //we need to set the component's attribute to the newly updated reference
        component.set("v.item",itemAttribute);
		
        //then, we get the button that generated the event
        //and set the disabled attribute to true
        event.getSource().set("v.disabled",true);
    }
})