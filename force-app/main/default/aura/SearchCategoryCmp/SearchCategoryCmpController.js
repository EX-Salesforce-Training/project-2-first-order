({
    init: function (cmp, event, helper) {
        
    },
    searchOpp: function (cmp,event,helper){
        let searchVal = cmp.get("v.searchKeyword"); 
        let cbVal = cmp.find("checkField").get("v.value");
        let rating = cmp.get("v.newRating");
        helper.getData(searchVal,cbVal,rating, cmp);

    },
    //Catching ratingEvent     
    ratingChange : function(cmp, event, helper) {
        let rating = event.getParam("rating");
        cmp.set("v.newRating", rating);
    },
    
    //Catching searchBarEvent
    updateSearchKey : function(cmp, event, helper) {
        let searchKey = event.getParam("searchKeyEvent");
        cmp.set("v.searchKeyword",searchKey);
    } 
})