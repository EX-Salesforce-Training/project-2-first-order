({
    doInit : function(component, event, handler) {
        let productList;
        let getProducts = component.get("c.GetProducts");
        getProducts.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                productList = response.getReturnValue();
        		component.set("v.productArray", productList);
            }
        });
        $A.enqueueAction(getProducts);
    },
    
    nextSlide : function(component, event, handler) {
    	let trendingCarousel = document.querySelector("#trendingCarousel");
        handler.replaceClassesNext(trendingCarousel);
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
    
    prevSlide : function(component, event, handler) {
    	let trendingCarousel = document.querySelector("#trendingCarousel");
        handler.replaceClassesPrev(trendingCarousel);
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
	},
    
})