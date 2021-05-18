@isTest
public class SearchCategoryControllerTest {
    @isTest(SeeAllData=false)
    static void TestSearchCategoryController(){
        // Test data setup
        List<Store_Product__c> testPros = new List<Store_Product__c>();
        for(Integer i = 0; i < 10; i++){
            testPros.add(new Store_Product__c(Name='Balloons'+i,Category__c='Confetti',IsRented__c = false,Price_Per_Unit__c=12.99,Rating__c=80));
        }
        for(Integer i = 0; i < 10; i++){
            testPros.add(new Store_Product__c(Name='Balloons'+i,Category__c='Halloween',IsRented__c = false,Price_Per_Unit__c=12.99,Rating__c=80));
        }
        
        // insert test data
        insert testPros;
        
        // Setting parameters for method 
        Test.startTest();
        Integer pageSize = 100;
        Integer pageNumber = 1;
        Integer price = 300;
        String rating = '5';
        String searchKeyword = null;
        String [] cbFilter = new String []{'Confetti','Birthday'};
        Boolean rental = false;
        
        // declare return list results
        List <Store_Product__c> myPro = new List <Store_Product__c>();
        
        // With checkbox filter 
        myPro = SearchCategoryController.getPro(pageSize, pageNumber, price, rating, searchKeyword, cbFilter, rental);
        System.debug(myPro);
        System.debug(myPro.size());
        System.assertEquals(10,myPro.size());
        
        // Without checkbox filter 
        cbFilter = new List<String>();
        myPro = SearchCategoryController.getPro(pageSize, pageNumber, price, rating, searchKeyword, cbFilter, rental);
        Test.stopTest();
        System.debug(myPro);
        System.debug(myPro.size());
        System.assertEquals(20,myPro.size());
    }
}