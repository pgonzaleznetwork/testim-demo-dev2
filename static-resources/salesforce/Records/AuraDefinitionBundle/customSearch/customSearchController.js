({
	handleClick : function(component, event, helper) {
        
        var searchTextAttribute = component.get("v.searchText");
        var action = component.get("c.searchForIds");
        console.log(action.getName());
        console.log(action.getParams());
        action.setParams({
            searchText : searchTextAttribute
        });
        action.setCallback(this,function(response){
            console.log("Setting callback for apex action");
            var state = response.getState();
            if(state === "SUCCESS"){
                var ids = response.getReturnValue();
                sessionStorage.setItem('customSearch--recordIds',JSON.stringify(ids));
                var navEvt = $A.get('e.force:navigateToURL');
                navEvt.setParams({
                    url:'/custom-search-results'
                });
                navEvt.fire();
            }
        });
        
        $A.enqueueAction(action);
		
	}
})