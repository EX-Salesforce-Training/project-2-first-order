public class TopListController {
	
    @AuraEnabled
    public static List<Store_Product__c> GetProducts() {

        return [SELECT Id, Name, Category__c, Rating__c, Price_Per_Unit__c, 
                Star_Rating__c, Product_Description__c, Rental_Start__c, Rental_End__c 
                FROM Store_Product__c ORDER BY Star_Rating__c DESC LIMIT 10];
    }
}