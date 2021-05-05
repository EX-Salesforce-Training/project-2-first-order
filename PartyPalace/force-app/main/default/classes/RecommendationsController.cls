////////////////////////////////////////
//
//	Name: RecommendationsController
//	Author: Abdul-Shahid Wali
//	Created: 4/30/21
//	Updated: 5/04/21
//	Description: Custom Controller for the RecommendationsView visualforce page
//	
////////////////////////////////////////


public class RecommendationsController {
    
    public string category {get;set;}
    public string clickedItem {get;set;}
    public List<Store_Product__c> productsToRecommend {get;set;}
    
 	//Filters store products by category
    public void GetRecommendations(){
        String s = 'SELECT Name, Category__c FROM Store_Product__c WHERE Category__c =: category';
        productsToRecommend = database.query(s);

    }
    //Adds an store product to the customer's cart. Currently non-functional
    public void AddToCart(){
        String userID = userInfo.getUserId();
        User currentUser = [SELECT ContactID FROM User WHERE Id =: userID];
        //Get an active transaction
        Transaction__c  trans = [SELECT Id FROM Transaction__c WHERE Status__c = 'Active'];
        //Get the product the customer clicked on
        Store_Product__c product = [SELECT Id FROM Store_Product__c WHERE Name =: clickedItem];
        //Create a new product line for the current product and transaction
        Product_Line__c productLine = new Product_Line__c(Product__c = product.Id, Transaction__c = trans.id, Quantity__c = 1);
    }

}