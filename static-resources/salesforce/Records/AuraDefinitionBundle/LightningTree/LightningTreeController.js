({
	doInit : function(component, event, helper) {
		
        var items = [
            {"label":"Ireland",
             "name":"Ireland",
             "expanded":false,
             "items":[
                 {"label":"Dublin",
                  "name":"Dublin",
                  "items":[]},
                 {"label":"Kerry",
                  "name":"Kerry",
                  "items":[]}
             ]},
            {"label":"Costa Rica",
             "name":"Costa Rica",
             "expanded":false,
             "items":[
                 {"label":"San Jose",
                  "name":"San Jose",
                  "items":[]},
                 {"label":"Cartago",
                  "name":"Cartago",
                  "items":[]}
             ]}
            ];
        
        component.set("v.items",items);
        
	},
    
    handleSelect : function(component, event, helper) {
		
        event.preventDefault();
        
        
        component.set("v.selected",event.getParam('name'));
	}
    
    
})