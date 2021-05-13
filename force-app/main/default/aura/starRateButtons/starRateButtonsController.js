({
	doInit : function(component, event, helper) {
		let x = component.get("v.number");
        if(x>5){
            x = 5;
        }else if(x<0){
            x = 0;
        }
        for(var i = 1; i <= x; i++){
            let strin = 'star'+i;
            $A.util.removeClass(component.find("star" + i), 'starDim');
            $A.util.addClass(component.find(strin), 'starGlow');
        }
	}
})