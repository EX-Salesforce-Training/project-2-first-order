@isTest
public class TopListControllerTest {
	
    @testSetup
    public static void setupTest() {
        List<Store_Product__c> pList = new List<Store_Product__c>();
        for (Integer i = 0; i < 150; i++) {
            Store_Product__c newProduct = new Store_Product__c();
            newProduct.Category__c = 'Banners';
            newProduct.Rating__c = Math.mod(i, 100);
            pList.add(newProduct);
        }
        Insert pList;
    }
    
    @isTest
    public static void TP_GetProducts() {
        List<Store_Product__c> expectedResults = [SELECT id FROM Store_Product__c ORDER BY Star_Rating__c DESC LIMIT 10];
        List<Store_Product__c> actualResults = TopListController.GetProducts();
        
        System.assertEquals(10, actualResults.size());
        for(Integer i = 0; i < actualResults.size(); i++) {
            System.assertEquals(expectedResults.get(i).id, actualResults.get(i).id);
        }
    }
}