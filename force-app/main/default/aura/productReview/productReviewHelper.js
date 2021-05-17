({
    // make call to apex controller and upsert the new review
	submitTheReview : function(component, newReview, storeProductID){
        let action = component.get("c.submitOrUpdateReview")  
        action.setParams({"re": newReview});
        action.setCallback(this, function(response){
            let state = response.getState();
            if(state === "SUCCESS"){
				// just going to use toast to let user know if their review was submitted
                component.find('notifier').showToast({
                    "variant" : "success",
                    "title" : "Review Saved!",
                    "message" : "Thank you for your time."

                });
            }else{
                component.find('notifier').showToast({
                    "variant" : "error",
                    "title" : "Trouble Submitting Review.",
                    "message" : "Sorry, please try again."

                });
            }
            
        });
        
        $A.enqueueAction(action);
    }
})