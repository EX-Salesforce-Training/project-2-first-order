({
	Paginate : function(component) {
        let currPage = component.get("v.currPage");
        let pageSize = component.get("v.pageSize");
        let listToPaginate = component.get("v.allProducts");
		let start = currPage * pageSize;
        let paginatedList = [];
        
        for(let i = start; i < start + pageSize; i++) {
            paginatedList.push(listToPaginate[i]);
        }
        
        return paginatedList;
	},
    
    displayText : function(component) {
        let currPage = component.get("v.currPage");
        let pageSize = component.get("v.pageSize");
        let allProducts = component.get("v.allProducts");
        
        let returnString = "Displaying Products " + (currPage * pageSize + 1) + 
            " to " + Math.min((currPage + 1) * pageSize, allProducts.length) + " of " + allProducts.length;
        return returnString;
    },
    
    getSubdivisionList : function(component) {
        let allProducts = component.get("v.allProducts");
        let currPage = component.get("v.currPage");
        let pageSize = component.get("v.pageSize");
        let cardsPerRow = component.get("v.numCols");
        let sdList = [];
        
        let max = Math.min(pageSize, allProducts.length - pageSize * currPage);
        console.log(max);
        for (let i = cardsPerRow; i < max - 1; i += cardsPerRow) {
            sdList.push(i);
        }
        sdList.push(max);
		console.log(sdList);
        return sdList;
    }
})