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
        var rating = cmp.get("v.newRating");
        
        debugger;
        
        helper.getData(searchVal,cbVal,rating, cmp);
        
        
        
        let trendingCarousel = document.querySelector("#trendingCarousel");
        if (trendingCarousel.classList.contains("first")) {
            trendingCarousel.classList.remove("first");
            trendingCarousel.classList.add("jumptoFirst");
        }
        if (trendingCarousel.classList.contains("scrollLeft1")) {
            trendingCarousel.classList.remove("scrollLeft1");
            trendingCarousel.classList.add("jumptoFirst");
        }
        else if (trendingCarousel.classList.contains("scrollLeft2")) {
            trendingCarousel.classList.remove("scrollLeft2");
            trendingCarousel.classList.add("jumptoFirst");
        }
            else if (trendingCarousel.classList.contains("scrollLeft3")) {
                trendingCarousel.classList.remove("scrollLeft3");
                trendingCarousel.classList.add("jumptoFirst");
            }
                else
                    trendingCarousel.classList.add("jumptoFirst");
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
        var rating = event.getParam("rating");
        cmp.set("v.newRating",rating);
    },
    
    updateSearchKey : function(cmp, event, helper) {
        var searchKey = event.getParam("searchKeyEvent");
        cmp.set("v.searchKeyword",searchKey);
        debugger;
    },
    
    
    nextSlide : function(cmp, event, helper) {
        let trendingCarousel = document.querySelector("#trendingCarousel");
        helper.replaceClassesNext(trendingCarousel);
        if (trendingCarousel.classList.contains("first")) {
            trendingCarousel.classList.remove("first");
        }
        if (trendingCarousel.classList.contains("scrollLeft1")) {
            trendingCarousel.classList.remove("scrollLeft1");
            trendingCarousel.classList.add("scrollLeft2");
        }
        else if (trendingCarousel.classList.contains("scrollLeft2")) {
            trendingCarousel.classList.remove("scrollLeft2");
            trendingCarousel.classList.add("scrollLeft3");
        }
            else if (trendingCarousel.classList.contains("scrollLeft3")) {
                trendingCarousel.classList.remove("scrollLeft3");
                trendingCarousel.classList.add("first");
            }
                else
                    trendingCarousel.classList.add("scrollLeft1");
    },
    
    prevSlide : function(cmp, event, helper) {
        let trendingCarousel = document.querySelector("#trendingCarousel");
        helper.replaceClassesPrev(trendingCarousel);
        if (trendingCarousel.classList.contains("last")) {
            trendingCarousel.classList.remove("last");
            trendingCarousel.classList.add("scrollRight3");
        }
        else if (trendingCarousel.classList.contains("scrollRight2")) {
            trendingCarousel.classList.remove("scrollRight2");
            trendingCarousel.classList.add("scrollRight1");
        }
            else if (trendingCarousel.classList.contains("scrollRight3")) {
                trendingCarousel.classList.remove("scrollRight3");
                trendingCarousel.classList.add("scrollRight2");
            }
                else if (trendingCarousel.classList.contains("scrollRight1")) {
                    trendingCarousel.classList.remove("scrollRight1");
                    trendingCarousel.classList.add("last");
                }
                    else
                        trendingCarousel.classList.add("last");
    }
    
    
    
    
})