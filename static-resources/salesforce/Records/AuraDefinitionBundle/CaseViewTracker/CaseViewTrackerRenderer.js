({
	unrender: function (component) {
    this.superUnrender();
        console.log('Component has been destroyed! Oh No!!!')
        var action = component.get("c.updateOwnerActiveTime");
        action.setParams({
            caseId : component.get("v.recordId"),
            numberOfSeconds : component.get("v.numberOfSecondsWhileTabIsActive")
        });
        action.setCallback(this,function(response){
            if(response.getState() == "SUCCESS"){
                console.log("The apex method was called as expected!");
            }
        });
        $A.enqueueAction(action);
}
})