({
    //we need to add our logic to take the correct product object from the list and add it to
    //the attribute cartList without overwriting existing items
    handleAddToCart : function(component, event, helper) {
      let itemAddedToCart = event.getParam("Store_Product__c");
      helper.helperItemRetrieval();
        


    }
})
