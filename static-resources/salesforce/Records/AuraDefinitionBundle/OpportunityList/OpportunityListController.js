({
	populateOpptys : function(component, event, helper) {
        
        console.log("this is being called");
        
        component.set("v.myColumns",[
            {label:"Name",fieldName:"Name",type:"text"},
            {label:"Stage",fieldName:"StageName",type:"text"},
            {label:"Amount",fieldName:"Amount",type:"currency"},
            {label:"Close Date",fieldName:"CloseDate",type:"date"}
        ]);
        
        console.log(component);
        
        var apexMethod = component.get("c.getOpptys");
        apexMethod.setParams({
            accountId : component.get("v.recordId")
        });
        
        apexMethod.setCallback(this,function(data){
            component.set("v.opptys",data.getReturnValue());
        });
        
        $A.enqueueAction(apexMethod);
		
	}
})