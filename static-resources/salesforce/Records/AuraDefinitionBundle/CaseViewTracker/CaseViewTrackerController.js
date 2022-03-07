({
    onTabFocused : function(component, event, helper) {

        var focusedTabId = event.getParam('currentTabId');
        var workspaceAPI = component.find("workspace");        
        workspaceAPI.getTabInfo({
            tabId : focusedTabId
        }).then(function(response) {//the response represents the tab info. We can add more case details here for filtering
            if(response.recordId != component.get("v.recordId")){
                console.log("The tab for a new case was opened, so I'll stop counting");
                component.set("v.myTabIsActive",false);
                
            }else if(response.recordId == component.get("v.recordId")){
                console.log("My tab is on focus again, so I'll continue counting");
                component.set("v.myTabIsActive",true);
            }
            console.log(response);
        });
    },
    
    startCounting :  function(component, event, helper){
        
        component.set("v.myTabIsActive",true);
         var numberOfSeconds = 0;
         var interval = window.setInterval(
                $A.getCallback(function() {
                    if (!component.isValid()){
                        window.clearInterval(interval);
                        console.log('Component no longer valid!');
                        return;
                    }
                    // code to execute periodically goes here
                    if(component.get("v.myTabIsActive")){
                        numberOfSeconds++;
                        console.log("Number of seconds for case Id "+component.get("v.recordId")+": "+numberOfSeconds);
                        component.set("v.numberOfSecondsWhileTabIsActive",numberOfSeconds);
                    }
                    
                }), 1000
            ); 
        
    }
})