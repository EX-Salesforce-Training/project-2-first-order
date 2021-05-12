({
    // handle event, update theItem, render the detail page, and get the reviews from apex controller.
	handleApplicationEvent : function(component, event, helper) {
		let theProduct = event.getParam("product");
        let strProd = JSON.stringify(theProduct);
                
        let rate = parseInt(theProduct.Star_Rating__c);
        component.set("v.ratingStar", rate);
        
        component.set("v.theItem", theProduct);
        console.log(strProd.Star_Rating__c);

        helper.getReviews(component, component.get("v.theItem").Id);
        // for the cases where detail is still open.
        component.set("v.toRender", false);
        component.set("v.toRender", true);
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