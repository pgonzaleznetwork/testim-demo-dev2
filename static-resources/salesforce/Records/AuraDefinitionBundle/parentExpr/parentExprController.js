({
	updateParentCompAttribute : function(component, event, helper) {
		component.set("v.parentCompAttribute","updated parent attribute");
	},
    
    onParentAttrChange: function(cmp, evt) {
        console.log("parentAttr has changed");
        console.log("old value: " + evt.getParam("oldValue"));
        console.log("current value: " + evt.getParam("value"));
    }
})