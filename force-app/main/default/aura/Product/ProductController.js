({
	productSelected : function(component, event, helper) {
        component.set("v.productName", "Clicked!");

        let selectedEvent = $A.get("e.c:ProductSelected");
        selectedEvent.setParam({"Product" : component.get("v.product")});
        selectedEvent.fire();
	}
})
