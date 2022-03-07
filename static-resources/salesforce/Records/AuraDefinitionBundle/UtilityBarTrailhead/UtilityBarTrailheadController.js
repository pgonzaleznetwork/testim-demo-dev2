({
    openUtilityBar : function(component, event, helper) {
        var utilityAPI = component.find("ubapi");
        utilityAPI.openUtility();
    },
    
    openTab : function(component, event, helper) {
        
        var contextRecordId = component.get("v.recordId");
        
        var recordURL = '#/sObject/'+contextRecordId+'/view';
        
        var workspaceAPI = component.find("wsapi");    
        workspaceAPI.openTab({
            url: recordURL,
            focus: true
        }).then(function(response) {        
            workspaceAPI.getTabInfo({
                tabId: response
            }).then(function(tabInfo) {
                console.log("The recordId for this tab is: " + tabInfo.recordId);
            });
        })    
        .catch(function(error) {
            console.log(error);
        });
    },
    
    onTabClosed : function(component,event,helper){
        var tabId = event.getParam("tabId");
        console.log("The Id of the tab that was closed is: "+tabId);
    },
    
    openContactTab : function(component,event,helper){
        var contactId = component.get("v.simpleRecord").ContactId;
        console.log("The contact Id is: "+contactId);
        
        var recordURL = '#/sObject/'+contactId+'/view';
        
        var workspaceAPI = component.find("wsapi");    
        workspaceAPI.openTab({
            url: recordURL,
            focus: true
        }).then(function(response) {        
            workspaceAPI.getTabInfo({
                tabId: response
            }).then(function(tabInfo) {
                console.log("The recordId for this tab is: " + tabInfo.recordId);
            });
        })    
        .catch(function(error) {
            console.log(error);
        });
        
    },
    
    handleRecordUpdated : function(component){
        //do nothing
    }
})