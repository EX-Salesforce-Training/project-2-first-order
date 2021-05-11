({
    // get the reviews, this is call when the event are handled
    getReviews : function(component, theProduct) {
        let action = component.get("c.getReviewList");
        action.setParams({"sp" : theProduct});
        action.setCallback(this, function(response){
            let state = response.getState();
            if(state === "SUCCESS"){
                let myList = response.getReturnValue();
                component.set("v.newReview", myList[myList.length -1]);
                myList.pop();
                component.set("v.reviewList", myList);
            }else{
                console.log("Couldn\'t get the reviews...");
            }
        });
        $A.enqueueAction(action);
    },
    // send the item to cart, 
    addItemToCart : function(component, theProduct, quantity){
        let buyEvent = $A.get("e.c:addToCart");
        buyEvent.setParams({"product": theProduct});
        buyEvent.fire();
    }
})