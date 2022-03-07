({
	getLabel : function(component, event, helper) {
        var labelName = 'Thank_you_for_the_feedback';
        console.log("Label value: "+$A.get("$Label.c."+labelName));
	},
    
    doInit : function(component, event, helper){
        //setting dynamic label hints
        //this will ensure the dynicamilly generated labels are present at compile time
        //wont scale if you have too many labels
        //$Label.c.Thank_you_for_the_feedback
    }
})