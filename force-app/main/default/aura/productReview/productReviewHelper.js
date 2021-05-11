({
    // make call to apex controller and upsert the new review
	submitTheReview : function(component, newReview){
        
        let action = component.get("c.submitOrUpdateReview")  
        action.setParams({"re": newReview});
        action.setCallback(this, function(response){
            
            let state = response.getState();
            var toastEvent = $A.get("e.force:showToast");
            
            if(state === "SUCCESS"){
                
                toastEvent.setParams({
                    "title": "Your Review Have Been Submitted!",
                    "message": "Thank you for your time.",
                    "type": "success"
                });
            }else{
                
                toastEvent.setParams({
                    "title": "Uh oh!",
                    "message": "Something went wrong.",
                    "type": "error"
                });
            }
            
            toastEvent.fire();
        });
        
        $A.enqueueAction(action);
    }
})