({
    // submit review for create or update.
	submitReview : function(component, event, helper){
        let reviewer = component.get("v.newReview");
        console.log(component.get("v.theItem").Id);
        helper.submitTheReview(component, component.get("v.newReview"), component.get("v.theItem").Id);
    },
    onclick1 : function(component, event, helper){
        component.set("v.newReview.Rating__c", 1);
    },
    onclick2 : function(component, event, helper){
        component.set("v.newReview.Rating__c", 2);
    },
    onclick3 : function(component, event, helper){
		component.set("v.newReview.Rating__c", 3);        
    },
    onclick4 : function(component, event, helper){
        component.set("v.newReview.Rating__c", 4);
    },
    onclick5 : function(component, event, helper){
        component.set("v.newReview.Rating__c", 5);
    }
})