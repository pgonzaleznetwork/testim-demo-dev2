({
    afterRender: function (cmp, helper) {
        this.superAfterRender();
        cmp.find('text1').getElement().addEventListener('paste', event => event.preventDefault());
    },
	rerender : function(cmp, helper){
        this.superRerender();
        cmp.find('text1').getElement().addEventListener('paste', event => event.preventDefault());
    }
})