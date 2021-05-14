({
	productSelected : function(component, event, helper) {
        component.set("v.productName", "Clicked!");

        let selectedEvent = $A.get("e.c:ProductSelected");
        console.log(selectedEvent);
        selectedEvent.setParams({"product" : component.get("v.product")});
        selectedEvent.fire();
	}
})
