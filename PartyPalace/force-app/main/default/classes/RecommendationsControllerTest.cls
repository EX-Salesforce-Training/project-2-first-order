////////////////////////////////////////
//
//	Name: RecommendationsControllerTest
//	Author: Abdul-Shahid Wali
//	Created: 5/04/21
//	Updated: 5/04/21
//	Description: Test class for the RecommendationsController class
//	
////////////////////////////////////////
@isTest
public class RecommendationsControllerTest {
    //Tests the two methods of the RecommendationController class
    @isTest public static void test(){
    RecommendationsController recCon = new RecommendationsController();
    Transaction__c trans = new Transaction__c(Status__c = 'Active');
    Store_Product__c product = new Store_Product__c(Name = 'Balloons');
    recCon.clickedItem = 'Balloons';
    insert trans;
    insert product;
    recCon.GetRecommendations();
    recCon.AddToCart();
    }

}