({
    
    
    init: function (cmp, event, helper) {
        
    },
    searchPro: function (cmp,event,helper){
        let searchVal = cmp.get("v.searchKeyword"); 
        let cbVal = cmp.find("checkField").get("v.value");
        let rating = cmp.get("v.newRating");
        helper.getData(searchVal,cbVal,rating, cmp);

    },
    
    //Catching ratingEvent     
    ratingChange : function(cmp, event, helper) {
        cmp.set("v.newRating", event.getParam("rating"));
    },
    
    //Catching searchBarEvent
    updateSearchKey : function(cmp, event, helper) {
        cmp.set("v.searchKeyword",event.getParam("searchKeyEvent"));
    },
    
    //Rental Change
    rentalChange : function(cmp, event, helper) {
        var checkBox = cmp.find("chkbox");
        cmp.set("v.rental",checkBox.get("v.value"));
    },

    searchClear: function(cmp, event, helper) {
        debugger;
        cmp.set("v.cbValue","");
        cmp.set("v.rental",false);
        cmp.set("v.ratingStar",0);
        cmp.set("v.price",300);
        //var searchr = cmp.find("search-rating");
        cmp.set("v.ratingStar",5);
        //searchr.update();
        
        cmp.find("search-rating").update();
        
    },
    /*isRefreshed: function(cmp, event, helper) {
        var checkBox = cmp.find("search-rating");
        
        checkBox.update();
    }*/
})