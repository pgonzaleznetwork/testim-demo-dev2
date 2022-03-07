({
	doInit : function(component, event, helper) {
		var device = $A.get("$Browser.formFactor");
        var locale = $A.get("$Locale.language");
        var logo = $A.get("$Resource.myLogoHe");
        
        console.log(device);
        console.log(locale);
        console.log(logo);
	}
})