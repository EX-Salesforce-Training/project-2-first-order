({
    getData : function(searchVal,cbVal,rating, cmp) {
        cmp.set('v.mycolumns', [
            { label: 'Name', fieldName: 'Name', type: 'text'},
            { label: 'Category', fieldName: 'Category__c', type: 'text'},
            { label: 'Price per item', fieldName: 'Price_Per_Unit__c', type: 'currency'},
            { label: 'Rating', fieldName: 'Rating__c', type: 'number'}
            
        ]);
        debugger;
        // Getting Values from the client to send to server
        var pageSize = cmp.get("v.pageSize").toString();
        var pageNumber = cmp.get("v.pageNumber").toString();
        var price = cmp.get('v.price').toString();
        
        
        // Creating the action for the server side
        var action = cmp.get('c.getPro');
        
        action.setParams({
            'cbFilter' 		: 	cbVal,
            'searchKeyword' : 	searchVal,
            'pageSize' 		:	pageSize,
            'pageNumber' 	:	pageNumber,
            'price' 		: 	price,
            'rating' 		: 	rating
        });
        
        
        // setting CallBack to interact with server side
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var resultData = response.getReturnValue();
                
                if(resultData.length < cmp.get("v.pageSize")){
                    cmp.set("v.isLastPage", true);
                } else{
                    cmp.set("v.isLastPage", false);
                }
                cmp.set("v.dataSize", resultData.length);
                cmp.set("v.mydata", resultData);
                
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    }
})