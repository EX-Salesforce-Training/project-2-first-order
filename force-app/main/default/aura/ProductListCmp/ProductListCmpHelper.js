({
    getData : function(searchVal,cbVal,rating, cmp) {

        // Getting Values from the client to send to server
        var pageSize = cmp.get("v.pageSize").toString();
        var pageNumber = cmp.get("v.pageNumber").toString();
        var price = cmp.get('v.price').toString();

        
        // Creating the action for the server side
        var action = cmp.get('c.getPro');
        
        action.setParams({
            'cbFilter' 		: 	cbVal,
            'searchKeyword' : 	searchVal,
            'pageSize' 		:	pageSize,
            'pageNumber' 	:	pageNumber,
            'price' 		: 	price,
            'rating' 		: 	rating
        });
        
        
        // setting CallBack to interact with server side
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var resultData = response.getReturnValue();
                
                if(resultData.length < cmp.get("v.pageSize")){
                    cmp.set("v.isLastPage", true);
                } else{
                    cmp.set("v.isLastPage", false);
                }
                cmp.set("v.dataSize", resultData.length);
                cmp.set("v.mydata", resultData);
                
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    },
    
    replaceClassesPrev : function(carousel) {
        if (carousel.classList.contains("scrollLeft1")) {
            carousel.classList.remove("scrollLeft1");
            carousel.classList.add("scrollRight2");
        }
        else if (carousel.classList.contains("scrollLeft2")) {
            carousel.classList.remove("scrollLeft2");
            carousel.classList.add("scrollRight3");
        }
        else if (carousel.classList.contains("scrollLeft3")) {
            carousel.classList.remove("scrollLeft3");
            carousel.classList.add("last");
        }
        else if (carousel.classList.contains("first")) {
            carousel.classList.remove("first");
            carousel.classList.add("scrollRight1");
        }
    }, 
    
    replaceClassesNext : function(carousel) {
        //Next to Previous
        if (carousel.classList.contains("scrollRight2")) {
            carousel.classList.remove("scrollRight2");
            carousel.classList.add("scrollLeft1");
        }
        else if (carousel.classList.contains("scrollRight3")) {
            carousel.classList.remove("scrollRight3");
            carousel.classList.add("scrollLeft2");
        }
        else if (carousel.classList.contains("last")) {
            carousel.classList.remove("last");
            carousel.classList.add("scrollLeft3");
        }
        else if (carousel.classList.contains("scrollRight1")) {
            carousel.classList.remove("scrollRight1");
            carousel.classList.add("first");
        }
    },
    
    
})