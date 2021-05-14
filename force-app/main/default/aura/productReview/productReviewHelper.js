({
    // make call to apex controller and upsert the new review
	submitTheReview : function(component, newReview, storeProductID){
        
        let action = component.get("c.submitOrUpdateReview")  
        action.setParams({"re": newReview, "sp": storeProductID});
        console.log(storeProductID);
        action.setCallback(this, function(response){
            
            let state = response.getState();
            //var toastEvent = $A.get("e.force:showToast");
            
            if(state === "SUCCESS"){
                console.log("SUCCESS!");
                /*
                toastEvent.setParams({
                    "title": "Your Review Have Been Submitted!",
                    "message": "Thank you for your time.",
                    "type": "success"
                });
                */
                component.set("v.reviewList", response.getReturnValue());
            }else{
                console.log("FAILURE!");
                /*
                toastEvent.setParams({
                    "title": "Uh oh!",
                    "message": "Something went wrong.",
                    "type": "error"
                });
                */
            }
            
            //toastEvent.fire();
        });
        
        $A.enqueueAction(action);
    }
})