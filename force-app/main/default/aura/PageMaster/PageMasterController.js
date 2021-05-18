({
    //Initialize the component with the current Users Contact ID
    doInit : function(component, event, helper) {
        let contactId;
        let getContactId = component.get("c.GetCurrentCID");
        getContactId.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                contactId = response.getReturnValue();
        		component.find("p-detail").set("v.userContactID", contactId);
            }
        });
        $A.enqueueAction(getContactId);
    },
    
    //Turns on the Product List
	turnOnList : function(component, event, helper) {
        
        //Jump to top of the container
        var top = document.querySelector("#content-container").getBoundingClientRect().top;
        window.scrollTo(window.pageXOffset, window.pageYOffset + top);
        
        //Select the list and view containers
		let pList = document.querySelector("#productlist");
        let dList = document.querySelector("#productview");
        
        //If both containers are active, hide the details and show the list
        if(component.get("v.dListOn") && component.get("v.pListOn")) {
            dList.classList.add("hide");
            component.set("v.dListOn", false);
            setTimeout(() => { 
       			pList.classList.remove("hidden");
                pList.classList.remove("hide");
        		pList.classList.add("shown");
            	component.set("v.pListOn", true);
            }, 500);
        }
        
        //If the list is off and the back button was clicked, just hide the details
        else if (!component.get("v.pListOn") && event.getName() == "click") {
            component.set("v.dListOn", false);
        	console.log(event.getName());
            dList.classList.add("hide");
        }
        else {
            
            //If the details are off, show the list. If not, swap
            if (!component.get("v.dListOn")) {
                pList.classList.remove("hidden");
                pList.classList.remove("hide");
        		pList.classList.add("shown");
            	component.set("v.pListOn", true);
            }
            else {
                dList.classList.add("hide");
                setTimeout(() => { 
       				pList.classList.remove("hidden");
                	pList.classList.remove("hide");
        			pList.classList.add("shown");
            		component.set("v.pListOn", true);
            	}, 500);
            }
        	component.set("v.dListOn", false);
        }
	},
    
    //Turns on the details
	turnOnDetails : function(component, event, helper) {
        
        //Jump to top of the container
        var top = document.querySelector("#content-container").getBoundingClientRect().top;
        window.scrollTo(window.pageXOffset, window.pageYOffset + top);
        
        //Retrieve the list and detail containers
		let pList = document.querySelector("#productlist");
        let dList = document.querySelector("#productview");
        
        //If the list is on swap
        if(component.get("v.pListOn")) {
            pList.classList.add("hide");
            setTimeout(() => { 
       			dList.classList.remove("hidden");
                dList.classList.remove("hide");
        		dList.classList.add("shown");
            	component.set("v.dListOn", true);
            }, 500);
        }
         
        //If the list is off, just show the details
        else {
            component.set("v.dListOn", true);
        	dList.classList.remove("hidden");
        	dList.classList.remove("hide");
        	dList.classList.add("shown");    
        }
	}
})