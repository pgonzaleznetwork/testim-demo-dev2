({
	handleRecordUpdated : function(component, event, helper) {
        console.log('Event type: '+event.getParams().changeType);
        console.log('This record was edited by another component');
	}
})