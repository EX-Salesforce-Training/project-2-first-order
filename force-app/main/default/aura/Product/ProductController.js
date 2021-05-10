({
	productSelected : function(component, event, helper) {
        component.set("v.productName", "Clicked!");
        
        let selectedEvent = component.getEvent("productSelected");
        selectedEvent.setParam({"Product" : component.get("v.product")});
        selectedEvent.fire();
	}
})