public class ProductDetailApexController {
    // sp = store product that they are looking at
    // cid = contact Id associate with the current user.
    @AuraEnabled
    public static List<Review__c> getReviewList(ID sp, ID cid){
        
        // list of all the review of the product
        List<Review__c> reviewList = [SELECT ID, Name, Comment__c, Rating__c, Contact__r.Name, Store_Product__c, Contact__c
                                      FROM Review__c 
                                      WHERE Store_Product__c=:sp ORDER BY Rating__c, LastModifiedDate DESC];
        
        // list of lists of review use to sort reviews
        List<List<Review__c>> returnList = new List<List<Review__c>>();
        Review__c currentUserReview;
        List<Review__c> currentStarList = new List<Review__c>();
        Integer lastRating = 5;
        /*
        for(Integer i = reviewList.size(); i >= 0; i--){
            
            // check if the current review is still from the same rating group
            if(reviewList[i].Rating__c != lastRating){
                
                // add currentStarList into return list
                returnList.add(currentStarList);
                
                // then make a new one for the new rating group
                currentStarList = new List<Review__c>();
                
            }
            
            // add current review
            currentStarList.add(reviewList[i]);
            
        }
        */
      	
        // append the current user review to the end of the list, so they can edit it.
        try{
            
            // try to get the review associate with the current product and contact, if none it will result in an error
            // contact__c need to be currentConID, currently hard coded in for testing.
            currentUserReview = [SELECT ID, Comment__c, Rating__c, Store_Product__c, Contact__r.Name, Contact__c 
                                 FROM Review__c 
                                 WHERE Store_Product__c=:sp and Contact__c=:cid limit 1];
        }catch(Exception e){
            
            // if they have no review yet, create a new review, but don't update the record in the database
            // just use it to populate the newReview attribute in the component, so if they do want to leave a review it will have the contactId
            // contact__c need to be currentConID, currently hard coded in for testing.
            currentUserReview = new Review__c(Store_Product__c=sp, Contact__c=cid);
            system.debug(e);
        }finally{
            reviewList.add(currentUserReview);
        }
        return reviewList;
    }
    @AuraEnabled
    public static List<Review__c> submitOrUpdateReview(Review__c re, ID sp){
        upsert re;
        return [SELECT ID, Name, Comment__c, Rating__c, Contact__r.Name, Store_Product__c FROM Review__c WHERE Store_Product__c=:sp];
    }
}