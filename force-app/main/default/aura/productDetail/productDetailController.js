({
    // handle event, update theItem, render the detail page, and get the reviews from apex controller.
	handleApplicationEvent : function(component, event, helper) {
		let theProduct = event.getParam("product");
        
        component.set("v.theItem", theProduct);
        component.set("v.toRender", true);
        helper.getReviews(component, component.get("v.theItem").Id);
	},
    // hide away the detail component use when the user want to go back to main page without interacting with add to cart
    hideDetail : function(component, event, helper){
        component.set("v.toRender", false);
    },
    // fire addToCart event then hide away the component
    addItem : function(component, event, helper){
        helper.addItemToCart(component, component.get("v.theItem"), component.get("v.quantity"));
        component.set("v.toRender", false);
    }
})