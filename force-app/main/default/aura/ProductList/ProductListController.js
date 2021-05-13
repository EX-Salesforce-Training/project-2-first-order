({
	doInit : function(component, event, helper) {
		let productList;
        let getProducts = component.get("c.GetProducts");
        getProducts.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                productList = response.getReturnValue();
        		component.set("v.allProducts", productList);
                component.set("v.pageProducts", helper.Paginate(component));
                
                component.set("v.displayText", helper.displayText(component));
                component.set("v.subdivisionList", helper.getSubdivisionList(component));
            }
        });
        $A.enqueueAction(getProducts);
	},
    
    nextPage : function(component, event, helper) {
        let currPage = component.get("v.currPage");
        if ((currPage + 1) * component.get("v.pageSize") >= component.get("v.allProducts").length)
            return;
        
        let listDiv = document.querySelector("#products");
        listDiv.classList.remove("rolldown");
        listDiv.classList.add("rollup");
        
        component.set("v.currPage", currPage + 1);
        setTimeout(() => { 
            component.set("v.pageProducts", helper.Paginate(component));
            component.set("v.displayText", helper.displayText(component));
            component.set("v.subdivisionList", helper.getSubdivisionList(component));
            listDiv.classList.remove("rollup");
            listDiv.classList.add("rolldown"); 
        }, 600);
    },
    
    prevPage : function(component, event, helper) {
        let currPage = component.get("v.currPage");
        if (currPage == 0)
            return;
        
        let listDiv = document.querySelector("#products");
        listDiv.classList.remove("rolldown");
        listDiv.classList.add("rollup");
        
        component.set("v.currPage", currPage - 1);
        setTimeout(() => { 
            component.set("v.pageProducts", helper.Paginate(component));
            component.set("v.displayText", helper.displayText(component));
            component.set("v.subdivisionList", helper.getSubdivisionList(component));
            listDiv.classList.remove("rollup");
            listDiv.classList.add("rolldown"); 
        }, 600);
    }
})