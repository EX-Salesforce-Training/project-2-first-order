({
    //we need to add our logic to take the correct product object from the list and add it to
    //the attribute cartList without overwriting existing items
    handleAddToCart : function(component, event, helper) {
        //debugger;
         // Geting oroduct from fired event
        let cartList = component.get("v.cartList");
        let itemAddedToCart = event.getParam("product");
        // Geting quantity from fired event
        let qtyList = component.get("v.qtyList");
        let qtyAddedToCart = parseInt(event.getParam("quantity"));
        
        //push quantity in the qtylist
        qtyList.push(qtyAddedToCart)
        component.set("v.qtyList", qtyList);
        
        //push product in the cartList
        cartList.push(itemAddedToCart);
        component.set("v.cartList", cartList);   
        
        
    },
    checkoutCart : function(component,event,helper){
        debugger;
        // get lists
        let cartList = component.get("v.cartList");
        let qtyList = component.get("v.qtyList");
        let contId = event.getParam("userContactID");
        
        // ApexController
        var action = component.get('c.savePurchase');
       
       action.setParams({
            'products' :  cartList,
            'quantity' :  qtyList,
           'contactID' :  contID
        });
        
        // setting CallBack to interact with server side
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var resultData = response.getReturnValue();

            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    },
})