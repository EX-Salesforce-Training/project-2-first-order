({
	turnOnList : function(component, event, helper) {
		let pList = document.querySelector("#productlist");
        pList.classList.remove("hidden");
        pList.classList.add("shown");
	}
})