({
	createItem : function(component,newItem) {
		var addEvent = component.getEvent("addItem");
        addEvent.setParams({ "item": newItem });
        addEvent.fire();
        
        component.set("v.newItem",{
                'sobjectType': 'Camping_Item__c',
                'Name': 'cedric',
                'Quantity__c': 20,
                'Price__c': 20,
                'Packed__c': false });
        console.log("component set to blank should have been called!");
	}
})