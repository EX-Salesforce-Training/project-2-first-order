public class ProductDetailApexController {
    // sp = store product that they are looking at
    // cid = contact Id associate with the current user.
    @AuraEnabled
    public static List<Review__c> getReviewList(ID sp, ID cid){
        
        // list of all the review of the product
        List<Review__c> reviewList = [SELECT ID, Name, Comment__c, Rating__c, Contact__r.Name, Store_Product__c FROM Review__c WHERE Store_Product__c=:sp];
        
        // use to get the current user contact
        // ID currentConID = [SELECT ID, ContactID FROM User WHERE Id=:UserInfo.getUserId() Limit 1].contactId;
        
        Review__c currentUserReview;
        
        // use 0035e000003ILKtAAO to test for a user that have a review; Jack
        // use 0035e000003ILL8AAO to test for a user that doesn't have a review; Avia
        ID reviewYes = '0035e000003ILKtAAO';
        ID reviewNo =  '0035e000003ILL8AAO';
        
        // append the current user review to the end of the list, so they can edit it.
        try{
            
            // try to get the review associate with the current product and contact, if none it will result in an error
            // contact__c need to be currentConID, currently hard coded in for testing.
            currentUserReview = [SELECT ID, Comment__c, Rating__c, Store_Product__c, Contact__r.Name, Contact__c 
                                 FROM Review__c 
                                 WHERE Store_Product__c=:sp and Contact__c=:reviewYes limit 1];
        }catch(Exception e){
            
            // if they have no review yet, create a new review, but don't update the record in the database
            // just use it to populate the newReview attribute in the component, so if they do want to leave a review it will have the contactId
            // contact__c need to be currentConID, currently hard coded in for testing.
            currentUserReview = new Review__c(Store_Product__c=sp, Contact__c=reviewNo);
            system.debug(e);
        }finally{
            reviewList.add(currentUserReview);
            system.debug(reviewList.size());
        }
        return reviewList;
    }
    @AuraEnabled
    public static List<Review__c> submitOrUpdateReview(Review__c re, ID sp){
        upsert re;
        return [SELECT ID, Name, Comment__c, Rating__c, Contact__r.Name, Store_Product__c FROM Review__c WHERE Store_Product__c=:sp];
    }
}