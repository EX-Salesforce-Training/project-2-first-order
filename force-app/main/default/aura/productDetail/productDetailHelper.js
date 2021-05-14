({
    // get the reviews, this is call when the event are handled
    getReviews : function(component, theProduct, userContactId) {
        let action = component.get("c.getReviewList");
        action.setParams({"sp" : theProduct, "cid" : userContactId });
        action.setCallback(this, function(response){
            let state = response.getState();
            if(state === "SUCCESS"){
                let myList = response.getReturnValue();
                // set the new review to the last thing in the list
                // that is where we store this user review of this product
                component.set("v.newReview", myList[myList.length -1]);
                // kill the last review because we only need it to update the current user review
                myList.pop();
                // now store the rest of the review, which includes the current user review
                component.set("v.reviewList", myList);
            }else{
                console.log("Couldn\'t get the reviews...");
            }
        });
        $A.enqueueAction(action);
    },
    // send the item to cart, 
    addItemToCart : function(component, theProduct, quantity, theProductLine, userContactId){
        let buyEvent = $A.get("e.c:addToCart");
        buyEvent.setParams({"userContactID": userContactId , "productLine": theProductLine, "product": theProduct, "quantity": quantity});
        buyEvent.fire();
    }
})