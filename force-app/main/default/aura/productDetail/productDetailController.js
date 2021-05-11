({
	handleApplicationEvent : function(component, event, helper) {
		let theProduct = event.getParam("product");
        
        component.set("v.theItem", theProduct);
        component.set("v.toRender", true);
        helper.getReviews(component, component.get("v.theItem").Id);
	},
    hideDetail : function(component, event, helper){
        component.set("v.toRender", false);
    },
    buyItem : function(component, event, helper){
        helper.buyTheItem(component, component.get("v.theItem"));
    },
    submitReview : function(component, event, helper){
        let reviewer = component.get("v.newReview");
        console.log(component.get("v.newReview"));
        helper.submitTheReview(component, component.get("v.newReview"));
    }
})