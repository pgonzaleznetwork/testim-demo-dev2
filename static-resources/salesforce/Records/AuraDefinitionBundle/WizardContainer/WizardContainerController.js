({
	showComponent : function(component, event, helper) {
        console.log("capturing event from child component - next component to show: "+event.getParam("componentName"));
                
        //find all the tabs in the path
        
        var whoTab = component.find('who');
        var dealTab = component.find('deal');
        var reviewTab = component.find('review');
        
        var componentToShow = event.getParam("componentName");
        
        switch(componentToShow){
            case "WizardComponent2Next":
                helper.showSecondComponent(component);
                //mark the first tab as completed
                $A.util.removeClass(whoTab,'slds-tabs--path__item slds-is-current');
                $A.util.addClass(whoTab,'slds-tabs--path__item slds-is-complete'); 
                //mark the 2nd tab as current
                $A.util.removeClass(dealTab,'slds-tabs--path__item slds-is-incomplete');
                $A.util.addClass(dealTab,'slds-tabs--path__item slds-is-current');
                
                break;
                
            case "WizardComponent2Back":
                helper.showSecondComponent(component);
                //mark the second tab as current
                $A.util.removeClass(dealTab,'slds-tabs--path__item slds-is-complete');
                $A.util.addClass(dealTab,'slds-tabs--path__item slds-is-current');
                //mark the 3rd one as incomplete
                $A.util.removeClass(reviewTab,'slds-tabs--path__item slds-is-current');
                $A.util.addClass(reviewTab,'slds-tabs--path__item slds-is-incomplete');
                
                break;
                
            case "WizardComponent1Back":
                helper.showFirstComponent(component);
                //mark the first tab as current and
                $A.util.removeClass(whoTab,'slds-tabs--path__item slds-is-complete');
                $A.util.addClass(whoTab,'slds-tabs--path__item slds-is-current');
                //mark the 2nd one as incomplete
                $A.util.removeClass(dealTab,'slds-tabs--path__item slds-is-current');
                $A.util.addClass(dealTab,'slds-tabs--path__item slds-is-incomplete');
                
                break;
                
            case "WizardComponent3Next":
                helper.showThirdComponent(component);
                //mark the third tab as current 
                $A.util.removeClass(reviewTab,'slds-tabs--path__item slds-is-incomplete');
                $A.util.addClass(reviewTab,'slds-tabs--path__item slds-is-current');
                //and set the 2nd one as complete
                $A.util.removeClass(dealTab,'slds-tabs--path__item slds-is-current');
                $A.util.addClass(dealTab,'slds-tabs--path__item slds-is-complete');
                break;
        }
        
	},
    
    doInit : function(component, event, helper) {
        
        console.log("executing init and hiding the 2nd and 3rd component.");
        
        var comp2 = component.find('WizardComponent2');
        
        console.log("comp2: "+comp2);
        
        var comp3 = component.find('WizardComponent3');
        
        $A.util.addClass(comp2,'invisible');
        $A.util.addClass(comp3,'invisible');
    }
})