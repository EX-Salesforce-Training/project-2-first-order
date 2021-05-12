({
	doInit : function(component, event, helper) {
		let x = component.get("v.number");
        if(x>5){
            x = 5;
        }
        for(var i = 1; i <= x; i++){
            component.set("v.starColor"+i, "Warning");
        }
	}
})