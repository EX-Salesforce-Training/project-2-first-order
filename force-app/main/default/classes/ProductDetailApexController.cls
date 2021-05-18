/*
 * Created by: Danny Tran
 * Description: get user reviews and upsert their review if they decide to do that.
 * 
 */
public class ProductDetailApexController {
    
    // sp = store product that they are looking at
    // cid = contact Id associate with the current user.
    @AuraEnabled
    public static Map<Integer, List<Review__c>> getReviewList(ID sp, ID cid){
        
        // list of all the review of the product except for the review associated with the current user
        // since they will be seeing their review on the writing section, we won't display it in reading section.
        List<Review__c> reviewList = [SELECT ID, Name, Comment__c, Rating__c, Contact__r.Name, Store_Product__c, Contact__c
                                      FROM Review__c 
                                      WHERE Store_Product__c=:sp AND Contact__c!=:cid ORDER BY Rating__c, LastModifiedDate DESC];
		
        // map that will be returning to the client side.
        Map<Integer, List<Review__c>> returnMap = new Map<Integer, List<Review__c>>();
        
        // query for 5 reviews types
        // If saving query is necessary you can also put each review in list using  the reviews from reviewList
        for(integer i = 1; i <= 5; i++){
            returnMap.put(i, [SELECT ID, Name, Comment__c, Rating__c, Contact__r.Name, Store_Product__c, Contact__c
                              FROM Review__c 
                              WHERE Store_Product__c=:sp AND Rating__c=:i AND Contact__c!=:cid
                              ORDER BY Rating__c, LastModifiedDate DESC]);
        }
        
        Review__c currentUserReview;
        
        // append the current user review to the end of the list, so we can get it easily.
        try{
            
            // try to get the review associate with the current product and contact, if none it will result in an error
            currentUserReview = [SELECT ID, Comment__c, Rating__c, Store_Product__c, Contact__r.Name, Contact__c 
                                 FROM Review__c 
                                 WHERE Store_Product__c=:sp and Contact__c=:cid limit 1];
        }catch(Exception e){
            
            // if they have no review yet, create a new review, but don't update the record in the database
            // just use it to populate the newReview attribute in the component, so if they do want to leave a review it will have the contactId and productid ready
            currentUserReview = new Review__c(Store_Product__c=sp, Contact__c=cid, Rating__c=5);
            system.debug(e);
        }finally{
            reviewList.add(currentUserReview);
        }
        
        // the 6th list will be the all review list
        returnMap.put(6, reviewList);
        
        // 7 total query 
        return returnMap;
    }
    @AuraEnabled
    public static void submitOrUpdateReview(Review__c re){
        upsert re;
    }
}