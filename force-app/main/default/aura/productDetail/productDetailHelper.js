({
    // get the reviews, this is call when the event are handled
    getReviews : function(component, theProduct, userContactId) {
        let action = component.get("c.getReviewList");
        action.setParams({"sp" : theProduct, "cid" : userContactId });
        action.setCallback(this, function(response){
            let state = response.getState();
            if(state === "SUCCESS"){
                let myMap = response.getReturnValue();
                component.set("v.newReview", myMap[6][myMap[6].length-1]);
                myMap[6].pop();
                component.set("v.reviewMap", myMap);
                component.set("v.reviewList", myMap[6]);
            }else{
                component.find('notifier').showToast({
                    "variant" : "error",
                    "title" : "We couldn't get review for the item.",
                    "message" : "Please try refreshing the page."
                });

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