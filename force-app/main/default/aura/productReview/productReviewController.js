({
    // submit review for create or update.
	submitReview : function(component, event, helper){
        let reviewer = component.get("v.newReview");
        helper.submitTheReview(component, component.get("v.newReview"));
    }
})