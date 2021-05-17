({
    // submit review for create or update.
	submitReview : function(component, event, helper){
        let reviewer = component.get("v.newReview");
        helper.submitTheReview(component, component.get("v.newReview"), component.get("v.theItem").Id);
    },
    ratingChange : function(cmp, event, helper) {
        let rating = event.getParam("rating");
        console.log('Rating: ' + rating);
        cmp.set("v.newReview.Rating__c",rating);
    },
    getOneStarReview : function(component, event, helper){
        let myMap = component.get("v.reviewMap");
        component.set("v.reviewList", myMap[1]);
    },
    getTwoStarReview : function(component, event, helper){
        let myMap = component.get("v.reviewMap");
        component.set("v.reviewList", myMap[2]);
    },
    getThreeStarReview : function(component, event, helper){
        let myMap = component.get("v.reviewMap");
        component.set("v.reviewList", myMap[3]);
    },
    getFourStarReview : function(component, event, helper){
        let myMap = component.get("v.reviewMap");
        component.set("v.reviewList", myMap[4]);
    },
    getFiveStarReview : function(component, event, helper){
        let myMap = component.get("v.reviewMap");
        component.set("v.reviewList", myMap[5]);
    },
    getAllReview : function(component, event, helper){
        let myMap = component.get("v.reviewMap");
        component.set("v.reviewList", myMap[6]);
    }
})