({
    //Swaps next classes with previous classes
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
    
    //Swaps previous classes with next classes
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
    }
})