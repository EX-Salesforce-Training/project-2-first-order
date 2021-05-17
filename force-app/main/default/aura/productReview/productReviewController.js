({	
    // submit review for create or update.
	submitReview : function(component, event, helper){
        let reviewer = component.get("v.newReview");
        helper.submitTheReview(component, component.get("v.newReview"), component.get("v.theItem").Id);
    },
    // change the rating of newReview whenever they click on the star
    ratingChange : function(cmp, event, helper) {
        let rating = event.getParam("rating");
        cmp.set("v.newReview.Rating__c",rating);
    },
    // switch out the current reviewlist with a different list on the map base on the user chosen sort.
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