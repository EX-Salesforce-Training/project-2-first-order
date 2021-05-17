({
    //we need to add our logic to take the correct product object from the list and add it to
    //the attribute cartList without overwriting existing items
    handleAddToCart : function(component, event, helper) {
        //debugger;

        // Geting oroduct from fired event
        let cartList = component.get("v.cartList");
        let itemAddedToCart = event.getParam("productLine");
        // Geting quantity from fired event
        let qtyList = component.get("v.qtyList");
        let qtyAddedToCart = parseInt(event.getParam("quantity"));
        
        let itemIndex = -1;
        for (let i = 0; i < cartList.length; i++) {
            if (cartList[i].Product__c.Name == itemAddedToCart.Product__c.Name) {
                itemIndex = i;
                break;
            }
        }
        if (itemIndex != -1) {
            cartList[itemIndex].Quantity__c += qtyAddedToCart;
            cartList[itemIndex].Total_Cost__c += qtyAddedToCart * cartList[itemIndex].Product__c.Price_Per_Unit__c;
        }
        else {
            //push quantity in the qtylist
            qtyList.push(qtyAddedToCart)
            
            //push product in the cartList
            cartList.push(itemAddedToCart);
        }  
        
        component.set("v.qtyList", qtyList);
        component.set("v.cartList", cartList); 
        
        let total = 0;
        for (let item of cartList) {
            total += item.Total_Cost__c;
        }
        component.set("v.total", total);
        component.set("v.cId", event.getParam("userContactID"));
    },
    
    checkoutCart : function(component,event,helper){
        debugger;
        // get lists
        let cartList = component.get("v.cartList");
        let qtyList = component.get("v.qtyList");
        let contId = component.get("v.cId");
        
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
    
    goToCheckout : function (component, event, helper) {
        let cOut = document.querySelector("#checkout");;
        cOut.classList.remove("hidden");
        cOut.classList.add("show");
    }
})