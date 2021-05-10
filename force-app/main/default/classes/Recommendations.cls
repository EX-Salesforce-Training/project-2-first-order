public class Recommendations {
    
    public string category {get;set;}
    public List<Store_Product__c> productsToRecommend {get;set;}
    
 
    public void getRecommendations(){
        String s = 'SELECT Name, Category__c FROM Store_Product__c WHERE Category__c =: category';
        productsToRecommend = database.query(s);

    }

}