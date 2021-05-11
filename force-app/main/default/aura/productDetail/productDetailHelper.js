({
	getReviews : function(component, theProduct) {
		let action = component.get("c.getReviewList");
        action.setParams({"sp" : theProduct});
        action.setCallback(this, function(response){
           let state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.reviewList", response.getReturnValue());
            }else{
                console.log("Couldn\'t get the reviews...");
            }
        });
        $A.enqueueAction(action);
	},
    buyTheItem : function(component, theProduct){
        let buyEvent = $A.get("e.c:ProductToBuy");
        buyEvent.setParams({"product": theProduct});
        buyEvent.fire();
    }
})