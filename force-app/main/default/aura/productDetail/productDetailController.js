({
	handleApplicationEvent : function(component, event, helper) {
		let theProduct = event.getParam("product");
        console.log(theProduct.Id);
        console.log(JSON.stringify(theProduct));
        let myStr = JSON.parse(JSON.stringify(theProduct));
        console.log(myStr.Id);
        
    	
        component.set("v.theItem", theProduct);
        component.set("v.toRender", true);
        console.log(component.get("v.theItem").Id);
        console.log(component.get("v.toRender"));
        helper.getReviews(component, component.get("v.theItem"));
        console.log(component.get("v.theItem"));
	},
    hideDetail : function(component, event, helper){
        component.set("v.toRender", false);
    },
    buyItem : function(component, event, helper){
        helper.buyTheItem(component, component.get("v.theItem"));
    }
})