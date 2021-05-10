@isTest
public class StoreProductsControllerTest {

    @isTest(SeeAllData=True)
    private static void renderPage(){
        Contact c = [SELECT Name,id FROM Contact WHERE firstName='David'];
        User u = [SELECT Name,id FROM User WHERE ContactId=:c.id];
        //PageReference PageRef = Page.StoreProductsView;
        //Test.setCurrentPage(PageRef);
        
        List<Store_Product__c> products = [SELECT Name FROM Store_Product__c LIMIT 15];
        System.RunAs(u){
            // initialized page correctly test
            StoreProductsController controller = new StoreProductsController();
            List<StoreProductsController.ProductsWrapper> wrapperList = controller.GetProductWrapper();
            system.assertEquals((products.size()/3), wrapperList.size());
            
            // next page test
            controller.next();
            products = [SELECT Name FROM Store_Product__c LIMIT 15 OFFSET 15];
         	wrapperList = controller.GetProductWrapper();
            system.assertEquals((products.size()/3)+1, wrapperList.size());
            
            // attempt to go to next page from last page
            controller.next();
            products = [SELECT Name FROM Store_Product__c LIMIT 15 OFFSET 15];
            wrapperList = controller.GetProductWrapper();
            system.assertEquals((products.size()/3)+1, wrapperList.size());
            
            // previous page test
            controller.prev();
            products = [SELECT Name FROM Store_Product__c LIMIT 15];
         	wrapperList = controller.GetProductWrapper();
            system.assertEquals((products.size()/3), wrapperList.size());
            
            // attempt to go to previous page from first page
            controller.prev();
            products = [SELECT Name FROM Store_Product__c LIMIT 15];
         	wrapperList = controller.GetProductWrapper();
            system.assertEquals((products.size()/3), wrapperList.size());
        }
    }
    
    @isTest
    private static void addToCart(){
        Contact c = [SELECT Name,id FROM Contact WHERE firstName='David'];
        User u = [SELECT Name,id FROM User WHERE ContactId=:c.id];
        Transaction__c userTrans = new Transaction__c(Status__c='Active');
        
        Store_Product__c product = new Store_Product__c(Name='test item');
        insert product;
        System.RunAs(u){
            StoreProductsController controller = new StoreProductsController();
            List<StoreProductsController.ProductsWrapper> wrapperList = controller.GetProductWrapper();
            controller.clickedItem = product.Name;
            controller.AddToCart();
            
            Product_Line__c lineItem = [SELECT Product__c,Transaction__c FROM Product_Line__c WHERE Transaction__c=:userTrans.id];
            Store_Product__c item = [SELECT Name FROM Store_Product__c WHERE Id=:lineItem.Product__c];
            system.assertEquals(product.Name, item.Name);
        }
    }
       
}