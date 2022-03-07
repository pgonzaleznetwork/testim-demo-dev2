({
	showActiveSectionName : function(component, event, helper) {
        console.log("Active Section Name: "+component.find("accordion").get("v.activeSectionName"));
	},
    
    setActiveSectionToC : function(component,event,helper){
        component.find("accordion").set("v.activeSectionName","soql");
    },
    
    toggleSOQL : function(component){
        component.set("v.displaySOQL",!component.get("v.displaySOQL"));
    }
})