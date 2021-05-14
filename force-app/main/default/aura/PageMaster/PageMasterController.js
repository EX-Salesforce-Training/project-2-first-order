({
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
    
	turnOnList : function(component, event, helper) {
		let pList = document.querySelector("#productlist");
        let dList = document.querySelector("#productview");
        console.log(event.getName());
        if(component.get("v.dListOn")) {
            dList.classList.add("hide");
            component.set("v.dListOn", false);
            setTimeout(() => { 
       			pList.classList.remove("hidden");
                pList.classList.remove("hide");
        		pList.classList.add("shown");
            	component.set("v.pListOn", true);
            }, 500);
        }
        else if (!component.get("v.pListOn") && event.getName() == "click") {
            component.set("v.dListOn, false");
            dList.classList.add("hide");
        }
        else {
            component.set("v.pListOn", true);
        	component.set("v.dListOn", false);
        	pList.classList.remove("hidden");
        	pList.classList.add("shown");    
        }
	},
    
	turnOnDetails : function(component, event, helper) {
		let pList = document.querySelector("#productlist");
        let dList = document.querySelector("#productview");
        if(component.get("v.pListOn")) {
            pList.classList.add("hide");
            setTimeout(() => { 
       			dList.classList.remove("hidden");
                dList.classList.remove("hide");
        		dList.classList.add("shown");
            	component.set("v.dListOn", true);
            }, 500);
        }
        else {
            component.set("v.dListOn", true);
        	component.set("v.dListOn", false);
        	dList.classList.remove("hidden");
        	dList.classList.remove("hide");
        	dList.classList.add("shown");    
        }
	}
})