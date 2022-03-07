({
    showFirstComponent : function(component) {
        
        var comp1 = component.find('WizardComponent1');
        var comp2 = component.find('WizardComponent2');
        var comp3 = component.find('WizardComponent3');
        
        $A.util.removeClass(comp1,'invisible');
        $A.util.addClass(comp2,'invisible');
        $A.util.addClass(comp3,'invisible');
        
    },
    
    showSecondComponent : function(component) {
        
        var comp1 = component.find('WizardComponent1');
        var comp2 = component.find('WizardComponent2');
        var comp3 = component.find('WizardComponent3');
        
        $A.util.addClass(comp1,'invisible');
        $A.util.removeClass(comp2,'invisible');
        $A.util.addClass(comp3,'invisible');
        
    },
    
    showThirdComponent : function(component) {
        
        var comp1 = component.find('WizardComponent1');
        var comp2 = component.find('WizardComponent2');
        var comp3 = component.find('WizardComponent3');
        
        $A.util.addClass(comp1,'invisible');
        $A.util.addClass(comp2,'invisible');
        $A.util.removeClass(comp3,'invisible');
        
    }
    
    
})