({
	doInit : function(component, event, helper) {
		let x = component.get("v.number");
        if(x>5){
            x = 5;
        }else if(x<0){
            x = 0;
        }
        for(var i = 1; i <= x; i++){
            component.set("v.starColor"+i, "Warning");
        }
	},
    numberChange : function(component, event, helper){
        
        let x = component.get("v.number");
        
        // when star increases
        for(var i = 1; i <= x; i++){
            component.set("v.starColor"+i, "Warning");
        }
        // for if stars were to reduce
        for(var i = x+1; i <= 5; i++){
            component.set("v.starColor"+i, "Inverse");
        }
    }
})