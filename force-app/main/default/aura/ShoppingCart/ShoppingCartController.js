({
    handleAddToCart : function(component, event, helper) {
        //figure what param we need, should be the object we're adding to our attribute list
        let addToCart=event.getParam("Store_Product__c")
        component.set("product")

    }
})
