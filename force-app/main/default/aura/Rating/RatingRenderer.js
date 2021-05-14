({ 
    afterRender : function(component, helper) { 
        var svg = component.find("svg_content");
        var colorOff = component.get("v.colorOff");
        var colorOn = component.get("v.colorOn");
        var stroke = component.get("v.stroke");
        var strokeWidth = component.get("v.strokeWidth");
        var initialRating = component.get("v.rating");
        var value = svg.getElement().innerText; 
        let finalString = "";
        
        for (let i = 0; i < initialRating; i++) {
            let workingString = value.substring(0, value.indexOf("</path>") + 7);
            value = value.substring(workingString.length - 1);
            
            workingString = workingString.replace(/#999999/g, colorOn);
            workingString = workingString.replace(/999/g, strokeWidth); 
        	workingString = workingString.replace(/#888888/g, stroke);
            finalString += workingString;
        }
        for (let i = initialRating; i < 5; i++) {
            let workingString = value.substring(0, value.indexOf("</path>") + 7);
            value = value.substring(workingString.length);
            
            workingString = workingString.replace(/#999999/g, colorOff);
            workingString = workingString.replace(/999/g, strokeWidth); 
        	workingString = workingString.replace(/#888888/g, stroke);
            finalString += workingString;
        }
        finalString += value;
        svg.getElement().innerHTML = finalString;
	}
})