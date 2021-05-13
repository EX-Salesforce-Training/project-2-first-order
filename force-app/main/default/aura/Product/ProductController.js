({
	productSelected : function(component, event, helper) {
        component.set("v.productName", "Clicked!");
        
        let selectedEvent = $A.get("e.c:ProductSelected");
        var con = component.get("v.product");
        
        selectedEvent.setParams({"product" : con});
        selectedEvent.fire();
	}
})