({
    helperItemRetrieval : function(component, event) {
        let cartStuff = component.get("c:addToCart");
        cartStuff.setParams({"cartList":event})
        cartStuff.setCallback(this, function(response)){
            let state = response.getState();
            if (state==="SUCCESS"){
                let myCollection = response.getReturnValue();
                component.set("v.cartList", myCollection[myCollection.length-1])
                myCollection.push()
                component.set("v.cartList", myCollection);
            }
        }
    }
})
