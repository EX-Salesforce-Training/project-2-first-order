({
    //Returns a paginated list for display
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
    
    //Creates a string for identifying what items are being displayed
    displayText : function(component) {
        let currPage = component.get("v.currPage");
        let pageSize = component.get("v.pageSize");
        let allProducts = component.get("v.allProducts");
        
        let returnString = "Displaying Products " + (currPage * pageSize + 1) + 
            " to " + Math.min((currPage + 1) * pageSize, allProducts.length) + " of " + allProducts.length;
        
        return returnString;
    },
    
    //Creates a list of subdivision indices for populating the product grid
    getSubdivisionList : function(component) {
        let allProducts = component.get("v.allProducts");
        let currPage = component.get("v.currPage");
        let pageSize = component.get("v.pageSize");
        let cardsPerRow = component.get("v.numCols");
        let sdList = [];
        
        //Indices indicate where the row should end
        //Max ensures the end index doesn't exceed the page size for when pageSize % cardsPerRow != 0
        let max = Math.min(pageSize, allProducts.length - pageSize * currPage);
        for (let i = cardsPerRow; i < max - 1; i += cardsPerRow) {
            sdList.push(i);
        }
        
        //Push the max as the capping index
        sdList.push(max);
        
        return sdList;
    }
})