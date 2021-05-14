({
    // make call to apex controller and upsert the new review
	submitTheReview : function(component, newReview, storeProductID){
        
        let action = component.get("c.submitOrUpdateReview")  
        action.setParams({"re": newReview, "sp": storeProductID});
        console.log(storeProductID);
        action.setCallback(this, function(response){
            
            let state = response.getState();
            
            if(state === "SUCCESS"){
                /*
                component.find('notifier').showToast({
                    "variant" : "success",
                    "title" : "Review Saved!",
                    "message" : "Thank you for your time."
                });*/
                component.set("v.reviewList", response.getReturnValue());
            }else{
                /*
                component.find('notifier').showToast({
                    "variant" : "error",
                    "title" : "Trouble Submitting Review.",
                    "message" : "Sorry, please try again."
                });*/
            }
            
        });
        
        $A.enqueueAction(action);
    }
})