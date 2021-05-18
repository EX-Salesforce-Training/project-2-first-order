@isTest
public class ShoppingCartApexTest {
    @TestSetup static void tests(){
        Contact cont = new Contact(LastName='namerson');
        Insert cont;
        Id recID = Schema.SObjectType.Store_Product__c.getRecordTypeInfosByName().get('Rental').getRecordTypeId();
        
        List<Store_Product__c> testPros = new List<Store_Product__c>();
        for(Integer i = 0; i < 10; i++){
            testPros.add(new Store_Product__c(Name='Balloons'+i,Category__c='Confetti',IsRented__c = false,Price_Per_Unit__c=12.99,Rating__c=80, recordTypeId=recID));
   			
        }
        Insert testPros;
        
    }
    

    
    @isTest public static void savePurchaseTest(){
        List<Product_Line__c> testProdLine = new List<Product_Line__c>();
        List<Store_Product__c> testpros = [SELECT name, category__c, price_per_unit__c, rating__c, recordTypeID FROM Store_Product__c ];
        for(Store_Product__c item : testPros){
            testProdLine.add(new Product_Line__c(product__c=item.Id, quantity__c=2));
        }
        Contact cont = [SELECT id FROM Contact];
        shoppingCartApexController.savePurchase(testProdLine, cont.Id);
        transaction__c things = [SELECT id, contact__c FROM transaction__c];
        Product_Line__c[] prodsline = [SELECT id, quantity__c, product__c, transaction__c FROM Product_Line__c];
        system.assertEquals(things.contact__c, cont.Id);
        system.assertEquals(prodsline.size(), testProdLine.size() );
    }
}