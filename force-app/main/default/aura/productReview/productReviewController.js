({
    // submit review for create or update.
	submitReview : function(component, event, helper){
        let reviewer = component.get("v.newReview");
        console.log(component.get("v.theItem").Id);
        helper.submitTheReview(component, component.get("v.newReview"), component.get("v.theItem").Id);
    }
})