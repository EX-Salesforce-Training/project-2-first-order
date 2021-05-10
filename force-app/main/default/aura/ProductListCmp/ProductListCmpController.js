({
    init: function (cmp, event, helper) {
        
       
        
        cmp.set('v.mapMarkers', [
            {
                location: {
                    Street: '11730 Plaza America Dr',
                    City: 'Reston',
                    State: 'VA'
                },

                title: 'The White House',
                description: 'Landmark, historic home & office of the United States president, with tours for visitors.'
            }
        ]);
        cmp.set('v.zoomLevel', 16);
     helper.getData(null,null,null,cmp);
    },
    
    searchOpp: function (cmp,event,helper){
        var searchVal = cmp.find("searchField").get("v.value"); 
        var cbVal = cmp.find("checkField").get("v.value");
        var rating = event.getParam("rating");
        
        helper.getData(searchVal,cbVal,rating, cmp);
    },	 
    
    boxFilter: function (cmp, event, helper) {
        var searchVal = cmp.find("searchField").get("v.value"); 
        var cbVal = cmp.find("checkField").get("v.value"); 
        var rating = event.getParam("rating");
        helper.getData(searchVal,cbVal,rating, cmp);
    },
    
    priceChange : function(cmp, event, helper) { 
        var searchVal = cmp.find("searchField").get("v.value"); 
        var priceChange = cmp.get("v.price");
        var cbVal = cmp.find("checkField").get("v.value");
        var rating = event.getParam("rating");
        cmp.set("v.price", priceChange);
         
        helper.getData(searchVal,cbVal,rating, cmp);
    },
    
    handleNext : function(cmp, event, helper) { 
        var searchVal = cmp.find("searchField").get("v.value"); 
        var pageNumber = cmp.get("v.pageNumber");
        var cbVal = cmp.find("checkField").get("v.value");
        var rating = event.getParam("rating");
        cmp.set("v.pageNumber", pageNumber+1);
         
        helper.getData(searchVal,cbVal,rating, cmp);

    },
    
    handlePrev : function(cmp, event, helper) {   
        var searchVal = cmp.find("searchField").get("v.value"); 
        var pageNumber = cmp.get("v.pageNumber");
        var cbVal = cmp.find("checkField").get("v.value");
        var rating = event.getParam("rating");
        cmp.set("v.pageNumber", pageNumber-1);
        
        helper.getData(searchVal,cbVal,rating, cmp);
    },
    
   ratingChange : function(cmp, event, helper) {
		var searchVal = cmp.find("searchField").get("v.value"); 
        var cbVal = cmp.find("checkField").get("v.value");
        var rating = event.getParam("rating");
       	
       helper.getData(searchVal,cbVal,rating, cmp);
	}
})