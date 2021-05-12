({
    //we need to add our logic to take the correct product object from the list and add it to
    //the attribute cartList without overwriting existing items
    handleAddToCart : function(component, event, helper) {
        let cartList = component.get("v.cartList");
      let itemAddedToCart = event.getParam("product");
      
      cartList.push(itemAddedToCart);
      component.set("v.cartList", cartList);
      
        


    }
})
