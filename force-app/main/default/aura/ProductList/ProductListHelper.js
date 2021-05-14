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
            " to " + ((currPage + 1) * pageSize) + " of " + allProducts.length;
        return returnString;
    },
    
    getSubdivisionList : function(component) {
        let pageSize = component.get("v.pageSize");
        let cardsPerRow = component.get("v.numCols");
        console.log(cardsPerRow);
        let sdList = [];
        for (let i = 0; i < pageSize; i += cardsPerRow) {
            sdList.push(i);
        }

        return sdList;
    }
})