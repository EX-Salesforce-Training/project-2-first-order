public class SearchCategoryController {
    @AuraEnabled
    public static List <Store_Product__c> getPro(Integer pageSize, Integer pageNumber,Integer price,
                                                 String rating,String searchKeyword,String [] cbFilter) {
        
        //convert rating
        Integer ratingInt = 5;
       	If(!String.isBlank(rating)){
            ratingInt=integer.valueOf(rating);
        }
       	ratingInt = (ratingInt*20);
                                                     
                                                     
        //convert offset                                             
        Integer offset = (pageNumber - 1) * pageSize;
		
        //if search key is blank then show everything if not blank search with wildcard                                              
 		String searchkey= String.isBlank (searchKeyWord) ? '%%' : '%'+searchKeyword+'%';
                                                     
        if(cbFilter.isEmpty()){
			 List<Store_Product__c> pros = [SELECT Id, Name, Category__c, Rating__c, Price_Per_Unit__c, Star_Rating__c, Product_Description__c,
                                            Rental_Start__c, Rental_End__c
                    FROM Store_Product__c
                    WHERE Name LIKE : searchkey
                    AND	  Price_Per_Unit__c <= : price
                    AND	  rating__c <= : ratingInt                        
                   		  LIMIT :pageSize OFFSET :offset
                          ];  
         	return pros;
        }
            List<Store_Product__c> pros = [SELECT Id, Name, Category__c, Rating__c, Price_Per_Unit__c, Star_Rating__c, Product_Description__c,
                                            Rental_Start__c, Rental_End__c 
                    FROM Store_Product__c
                    WHERE Name LIKE : searchkey
                    AND   Category__c IN:cbFilter
                    AND   Price_Per_Unit__c <= : price
                    AND	  rating__c <= : ratingInt
                          LIMIT :pageSize OFFSET :offset
                          ];            
        return pros;

    }
}