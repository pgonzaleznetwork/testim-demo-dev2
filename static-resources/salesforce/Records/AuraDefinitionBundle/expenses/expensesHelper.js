({
    createExpense: function(component, expense) {
        
        var apexMethod = component.get("c.saveExpense");
        
        apexMethod.setParams({
            "expense":expense
        });
        
        apexMethod.setCallback(this,function(response){
            if(response.getState() == "SUCCESS"){
                var expenses = component.get("v.expenses");
                expenses.push(response.getReturnValue());
                component.set("v.expenses",expenses);
            }
        });
        
        $A.enqueueAction(apexMethod);
    }
})