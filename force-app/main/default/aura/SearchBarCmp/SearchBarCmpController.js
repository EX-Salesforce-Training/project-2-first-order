({
	myAction : function(component, event, helper) {
		var searchKeyEvent = component.get("v.searchKeyword");
        //var myEvent = component.getEvent("SearchBarEvent");
        var myEvent = $A.get("e.c:SearchBarEvent");
        myEvent.setParams({"searchKeyEvent": searchKeyEvent});
        myEvent.fire();

	}
})