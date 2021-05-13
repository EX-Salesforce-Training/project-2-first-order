({
    doInit : function(component, event, helper) {
        
    },
    
	turnOnList : function(component, event, helper) {
		let pList = document.querySelector("#productlist");
        component.set("v.pListOn", true);
        pList.classList.remove("hidden");
        pList.classList.add("shown");
        component.find("p-list").set("v.numCols", 3);
	}
})