({
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
    submitTheReview : function(component, newReview){
        let action = component.get("c.submitOrUpdateReview")  
        action.setParams({"re": newReview});
        action.setCallback(this, function(response){
            let state = response.getState();
            if(state === "SUCCESS"){
                console.log("Success");
            }else{
                console.log("Failure");
            }
        });
        $A.enqueueAction(action);
    },
    buyTheItem : function(component, theProduct){
        let buyEvent = $A.get("e.c:addToCart");
        buyEvent.setParams({"product": theProduct});
        buyEvent.fire();
    }
})