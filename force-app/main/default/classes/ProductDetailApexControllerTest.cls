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
            // the one is the new review we create for the current customer, that get send back to the js controller
            // this new review is not inserted, it is just a review object to populate the new review attribute.
            List<Review__c> reviewList = ProductDetailApexController.getReviewList(sp.Id, currentUser.ContactID);
            
            System.assert(reviewList.size() == 1);
            
            // now test insertion of that review 
            // we should be able to just get the review from here;
            Review__c newReview = reviewList[0];
            
            // the user would rate and comment
            newReview.Rating__c = 4;
            newReview.Comment__c = 'Yes';
            
            // we then call the submitorupdateReview, in this case it will be an insert.
            // this will give back a list of updated reviews.
            // again there should only be 1 review here.
            reviewList =  ProductDetailApexController.submitOrUpdateReview(newReview, sp.Id);
            
			System.assert(reviewList.size() == 1);
            System.assertEquals(newReview.Id, reviewList[0].Id);
            System.assertEquals(newReview.Contact__c, reviewList[0].Contact__c);
            System.assertEquals(newReview.Store_Product__c, reviewList[0].Store_Product__c);
            System.assertEquals(newReview.Rating__c, reviewList[0].Rating__c);
            System.assertEquals(newReview.Comment__c, reviewList[0].Comment__c);
            
            // do it again, this time, it should have two review
            // two same review, but this was done so I don't have to search through the entire list of reviews on a product.
            // just need to pop() the last list member on js side before updating the review list.
            reviewList = ProductDetailApexController.getReviewList(sp.Id, currentUser.contactID);
			
            System.assert(reviewList.size() == 2);
            
            // now we test if they can update the review
            newReview = reviewList[0];
            newReview.Comment__c = 'Hohoho';
            newReview.Rating__c = 5;
            
            reviewList =  ProductDetailApexController.submitOrUpdateReview(newReview, sp.Id);
            
            // check again if the new review is updated correctly
            System.assert(reviewList.size() == 1);
            System.assertEquals(newReview.Id, reviewList[0].Id);
            System.assertEquals(newReview.Contact__c, reviewList[0].Contact__c);
            System.assertEquals(newReview.Store_Product__c, reviewList[0].Store_Product__c);
            System.assertEquals(newReview.Rating__c, reviewList[0].Rating__c);
            System.assertEquals(newReview.Comment__c, reviewList[0].Comment__c);
            
        }
    }
}