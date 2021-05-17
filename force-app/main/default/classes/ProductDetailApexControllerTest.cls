@isTest
public class ProductDetailApexControllerTest {
	
    @testSetup
    static void setup(){
        Account a = new Account(Name='Test Account Name');
  		insert a;
 
        Contact newCon = new Contact(LastName='The Tester2', AccountId = a.id);
        insert newCon;
        Profile custPro = [SELECT id FROM profile WHERE name = 'Test ccu'];
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
        
        Contact con1 = new Contact(LastName='Reviewer1', AccountId = a.id);
        insert con1;
        Contact con2 = new Contact(LastName='Reviewer2', AccountId = a.id);
        insert con2;
        Contact con3 = new Contact(LastName='Reviewer3', AccountId = a.id);
        insert con3;
        Contact con4 = new Contact(LastName='Reviewer4', AccountId = a.id);
        insert con4;
        Contact con5 = new Contact(LastName='Reviewer5', AccountId = a.id);
        insert con5;
        
        Review__c re1 = new Review__c(Contact__c=con1.Id, Store_Product__c=sp.Id, Comment__c='Heya1', Rating__c=1);
        insert re1;
        Review__c re2 = new Review__c(Contact__c=con2.Id, Store_Product__c=sp.Id, Comment__c='Heya2', Rating__c=2);
        insert re2;
        Review__c re3 = new Review__c(Contact__c=con3.Id, Store_Product__c=sp.Id, Comment__c='Heya3', Rating__c=3);
        insert re3;
        Review__c re4 = new Review__c(Contact__c=con4.Id, Store_Product__c=sp.Id, Comment__c='Heya4', Rating__c=4);
        insert re4;
        Review__c re5 = new Review__c(Contact__c=con5.Id, Store_Product__c=sp.Id, Comment__c='Heya5', Rating__c=5);
        insert re5;
    }
    
    @isTest
    public static void testPositive(){
        User currentUser = [SELECT ID, contactID FROM User WHERE LastName = 'user23232'];
        Store_Product__c sp = [SELECT ID, Name, Category__c, Price_Per_Unit__c, Product_Description__c FROM Store_Product__c];
        
        System.runAs(currentUser){
            // testing the init handler apex call to get map of product
            // key is the star rating of 1 to 5, and 6 is all the reviews
            Map<Integer, List<Review__c>> reviewMap = ProductDetailApexController.getReviewList(sp.Id, currentUser.ContactID);
            
            // there should be 6 key-value pair
            // even if there is no review for the product currently, it should still give us 6
            System.assert(reviewMap.size() == 6);
            
            // there should be 6 reviews in the last one 5 for the reviews we made, and 1 for the current user review
            Integer mapSize = reviewMap.get(6).size();
            System.assert(mapSize==6);
            
            // it should not have insert the new review yet, so the total number of review should still only be 5
            System.assert([SELECT count() FROM Review__c WHERE Store_Product__c=:sp.Id] == 5);
            
            // check if the new review is made for the user
            // it is the last review in the 6th list
            System.assert(reviewMap.get(6)[mapSize-1].Contact__c == currentUser.contactID);
            
            // get our review then delete it from the list
            Review__c newReview = reviewMap.get(6)[mapSize-1];
            
            // update the review
            reviewMap.get(6).remove(mapSize-1);
            newReview.Rating__c = 4;
            newReview.Comment__c = 'Yes';
            
            // insert it
            ProductDetailApexController.submitOrUpdateReview(newReview);
            Review__c queryReview;
            try{
                queryReview = [SELECT Id, Comment__c, Rating__c, Store_Product__c, Contact__c FROM Review__c WHERE Contact__c=:currentUser.ContactId];
            }catch(Exception e){
                
                // if we can't find a review of our customer, then it will be error and we have failed to insert
                System.assert(false);
            }
            
            // check if the content match
            System.assert(queryReview.Comment__c==newReview.Comment__c);
            System.assert(queryReview.Rating__c==newReview.Rating__c);
            
            // now let try updating our review
            // first let grab the map again and check if the last of the 6th the new review
            reviewMap = ProductDetailApexController.getReviewList(sp.Id, currentUser.ContactID);
            System.assert(reviewMap.get(6)[mapSize-1].Comment__c == 'Yes');
            System.assert(reviewMap.get(6)[mapSize-1].Rating__c == 4);
            
            // update it
            newReview = reviewMap.get(6)[mapSize-1];
            newReview.Rating__c = 1;
            newReview.Comment__c = 'Yesn\'t';
            
            ProductDetailApexController.submitOrUpdateReview(newReview);
            
            // this should give the same rating and comment.
            queryReview = [SELECT Id, Comment__c, Rating__c, Store_Product__c, Contact__c FROM Review__c WHERE Contact__c=:currentUser.ContactId];
            System.assert(queryReview.Comment__c==newReview.Comment__c);
            System.assert(queryReview.Rating__c==newReview.Rating__c);
        }
    }
}