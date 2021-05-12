({
	productSelected : function(component, event, helper) {
        let selectedEvent = component.getEvent("productSelected");
        selectedEvent.setParam({"Product" : component.get("v.product")});
        selectedEvent.fire();
	}
})
