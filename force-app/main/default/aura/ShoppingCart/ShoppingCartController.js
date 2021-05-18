({
    //we need to add our logic to take the correct product object from the list and add it to
    //the attribute cartList without overwriting existing items
    handleAddToCart : function(component, event, helper) {
        //debugger;

        // Geting oroduct from fired event
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
        debugger;
    },
    
    checkoutCart : function(component,event,helper){
        debugger;
        // get lists
        let cartList = component.get("v.items");
        let qtyList = component.get("v.qtyList");
        //let contId = component.get("v.cId");
        let contId = 'testcontactid';
        // ApexController
        var action = component.get('c.savePurchase');
        debugger;
        action.setParams({
            	'products' :  cartList,
				'quantity' :  qtyList,
            	'contactID' :  contId
        });
              //      'products' :  cartList,
            //'quantity' :  qtyList,
            //'contactID' :  contId
        //'contactID' :  contId
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
    },
})