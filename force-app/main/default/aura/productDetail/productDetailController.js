({
    // handle event, update theItem, render the detail page, and get the reviews from apex controller.
	handleApplicationEvent : function(component, event, helper) {
		let theProduct = event.getParam("product");
        let strProd = JSON.stringify(theProduct);
	
        let rate = parseInt(theProduct.Star_Rating__c);
        component.set("v.ratingStar", rate);
        
        // set theItem with the StoreProduct that arive from the event
        component.set("v.theItem", theProduct);
        
        // set theItemLine with the StoreProduct Id.
        component.set("v.theItemLine.Product__c",  theProduct.Id);
        
        // grab all the reviews for the current product, along with the current user review if they have any.
        helper.getReviews(component, component.get("v.theItem").Id, component.get("v.userContactID"));
        
	},
    // fire addToCart event
    // current also hide away the component but that won't be necessary in final.
    addItem : function(component, event, helper){
        component.set("v.theItemLine.Quantity__c", component.get("v.quantity"));
        component.set("v.theItemLine.Product__c", component.get("v.theItem"));
        component.set("v.theItemLine.Total_Cost__c", component.get("v.theItem.Price_Per_Unit__c") * component.get("v.quantity"));
        helper.addItemToCart(component, component.get("v.theItem"), component.get("v.theItemLine"), component.get("v.userContactID"));

    }
})