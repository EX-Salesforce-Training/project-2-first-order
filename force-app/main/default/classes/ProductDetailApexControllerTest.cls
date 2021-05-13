@isTest
public class ProductDetailApexControllerTest {
	
    @testSetup
    static void setup(){
        Account a = new Account(Name='Test Account Name');
  		insert a;
 
        Contact newCon = new Contact(LastName='The Tester2', AccountId = a.id);
        insert newCon;
        Profile custPro = [SELECT id FROM profile WHERE name = 'Customer Community User'];
        User customer = new User(LastName = 'user23232', 
                                 Username = 'user23.2@sfdc.com', 
                                 Email = 'usersf22132@gmail.com', 
                                 Alias = 'test22', 
                                 Phone = '00000000003',
                                 TimeZoneSidKey = 'GMT', 
                                 LocaleSidKey = 'en_GB', 
                                 EmailEncodingKey = 'ISO-8859-1', 
                                 ProfileId = custPro.id, 
                                 LanguageLocaleKey = 'en_US',
                                 contactID = newCon.Id,
                                IsActive = true,
                                CommunityNickname = 'testUser232'); 
        
        insert(customer);
        
        Store_Product__c sp = new Store_Product__c(Name='Test Prod', Category__c='Banners', Price_Per_Unit__c=23, Product_Description__c='yayayayayay');
        insert sp;
        
    }
    
    @isTest
    public static void testPositive(){
        User currentUser = [SELECT ID, contactID FROM User WHERE LastName = 'user23232'];
        Store_Product__c sp = [SELECT ID, Name, Category__c, Price_Per_Unit__c, Product_Description__c FROM Store_Product__c];
        System.runAs(currentUser){
            // testing the init handler apex call to get list of review on the product
            // get review List, it should be empty at this point but we will still get back 1
            // the one is the new review we create for the current customer, that sent back to the js controller
            List<Review__c> reviewList = ProductDetailApexController.getReviewList(sp.Id, currentUser.ContactID);
            
            System.assert(reviewList.size() == 1);
            
            Review__c newReview = [SELECT Id, Contact__c, Store_Product__c, Rating__c, Comment__c FROM Review__c Limit 1];
            reviewList =  ProductDetailApexController.submitOrUpdateReview(newReview, currentUser.ContactId);
              
            // do it again, this time, it should have two review
            // two same review, but this was done so I don't have to search through the entire list of reviews on a product.
            // so I will just pop() the last list member on js side before updating the review list.
            //reviewList = ProductDetailApexController.getReviewList(sp.Id, currentUser.contactID);
			
            //System.assert(reviewList.size() == 2);
            
        }
    }
}