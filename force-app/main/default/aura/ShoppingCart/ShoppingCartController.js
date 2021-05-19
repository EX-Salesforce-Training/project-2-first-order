({
    //we need to add our logic to take the correct product object from the list and add it to
    //the attribute cartList without overwriting existing items
    handleAddToCart : function(component, event, helper) {
        //debugger;

        // Geting product from fired event
        let cartList = component.get("v.cartList");
        let allItems = component.get("v.items");
        let itemAddedToCart = event.getParam("productLine");
        allItems.push(event.getParam("product"));
        
        // Geting quantity from fired event
        let qtyList = component.get("v.qtyList");
        let qtyAddedToCart = itemAddedToCart.Quantity__c;
        
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
        component.set("v.items", allItems);
        component.set("v.cId", event.getParam("userContactID"));
        let x = [];
        for(let item of cartList){
            x.push(item.Product__c);
        }
        component.set("v.StoreProductTest", x);
    },
    
    checkoutCart : function(component,event,helper){
        
        // get lists
        let cartList = component.get("v.cartList");
        console.log(cartList);
        let storeProductList = component.get("v.StoreProductTest");
        let contId = component.get("v.cId");
        var action = component.get('c.savePurchase');
        action.setParams({
            'storeProdList' : storeProductList,
            	'prodList' :  cartList,
            	'contactID' :  contId
        });
         // setting CallBack to interact with server side
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
				console.log('success');
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.log(errors);
            }
        });
        $A.enqueueAction(action);
    },
    
    goToCheckout : function (component, event, helper) {
        let cOut = document.querySelector("#checkout");;
        cOut.classList.remove("hidden");
        cOut.classList.add("show");
    },
})
