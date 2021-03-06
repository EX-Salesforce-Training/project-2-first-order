({
    starClick : function(component, event, helper) {
        if (!component.get("v.editable"))
            return;
        var colorOn = component.get("v.colorOn"); 
        var colorOff = component.get("v.colorOff");
        var el = event.target;
        
        var rating = 0;
        while (el) {
            console.log(el.nodeName);
            rating++;
	        el.style.fill = colorOn;
			el = el.previousElementSibling;    		        
        }
        el = event.target.nextElementSibling;
        while (el) {
            console.log(el.nodeName);
	        el.style.fill = colorOff;
			el = el.nextElementSibling;   
        }
        component.set("v.rating", rating);
        var myEvent = component.getEvent("change");
        myEvent.setParams({"rating": rating});
        myEvent.fire();

    },
    onRender : function(component, helper) { 
        var svg = component.find("svg_content");
        var colorOff = component.get("v.colorOff");
        var colorOn = component.get("v.colorOn");
        var stroke = component.get("v.stroke");
        var strokeWidth = component.get("v.strokeWidth");
        var initialRating = component.get("v.rating");
        var value = svg.getElement().innerHTML; 
        let finalString = "";
        
        for (let i = 0; i < initialRating; i++) {
            
            let workingString = value.substring(0, value.indexOf("</path>") + 7);
            value = value.substring(workingString.length - 1);
            
            workingString = workingString.substring(0, workingString.indexOf("fill=") + 6) + colorOn +
                workingString.substring(workingString.indexOf("fill=") + 6 + 7);
            finalString += workingString;
        }

        for (let i = initialRating; i < 5; i++) {
            let workingString = value.substring(0, value.indexOf("</path>") + 7);
            value = value.substring(workingString.length);
            
            workingString = workingString.substring(0, workingString.indexOf("fill=") + 6) + colorOff +
                workingString.substring(workingString.indexOf("fill=") + 6 + 7);
            finalString += workingString;
        }
        finalString += value;
        svg.getElement().innerHTML = finalString;
	}
})