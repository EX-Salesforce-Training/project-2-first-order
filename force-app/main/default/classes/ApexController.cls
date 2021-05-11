public class ApexController {
	@AuraEnabled
    public static List<Review__c> getReviewList(Store_Product__c sp){
        system.debug(sp.Id);
        List<Review__c> reviewList = [SELECT ID, Name, Comment__c, Rating__c, Contact__r.Name, Store_Product__c FROM Review__c WHERE Store_Product__c=:sp.Id];
        
        return reviewList;
    }
}