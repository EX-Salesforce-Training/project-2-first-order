public class ApexController {
	@AuraEnabled
    public static List<Review__c> getReviewList(ID sp){
        List<Review__c> reviewList = [SELECT ID, Name, Comment__c, Rating__c, Contact__r.Name, Store_Product__c FROM Review__c WHERE Store_Product__c=:sp];
        
        // use to get the current user contact
        // ID currentConID = [SELECT ID, ContactID FROM User WHERE Id=:UserInfo.getUserId() Limit 1].contactId;
        
        Review__c currentUserReview;
        // use 0035e000003ILKtAAO to test for a user that have a review
        // use 0035e000003ILL8AAO to test for a user that doesn't have a review
        ID reviewYes = '0035e000003ILKtAAO';
        ID reviewNo =  '0035e000003ILL8AAO';
        
        // append the current user review to the end of the list, so they can edit it.
        // if they have no review, 
        try{
            
            currentUserReview = [SELECT ID, Comment__c, Rating__c, Store_Product__c, Contact__r.Name, Contact__c 
                                 FROM Review__c 
                                 WHERE Store_Product__c=:sp and Contact__c=:reviewNo limit 1];
        }catch(Exception e){
            // if they have no review yet, create a new review, but don't update the record in the database
            // just use it to populate the newReview attribute in the component, so if they do want to leave a review it will have the contactId
            // contact__c need to be currentConID, hard code for testing.
            currentUserReview = new Review__c(Store_Product__c=sp, Contact__c=reviewNo);
            system.debug(e);
        }finally{
            reviewList.add(currentUserReview);
            system.debug(reviewList.size());
        }
        return reviewList;
    }
    @AuraEnabled
    public static void submitOrUpdateReview(Review__c re){
        // comment out for testing.
        system.debug('Review Submitted or Updated');
        //upsert re;
    }
}