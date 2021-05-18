public class SearchCategoryController {
    @AuraEnabled
    public static List <Store_Product__c> getPro(Integer pageSize, Integer pageNumber,Integer price,
                                                 String rating,String searchKeyword,String [] cbFilter, Boolean rental) 
    {
        // getting record type id from the the Store_Product__c
        Set <ID> recordType_ID = new Set <ID> ();
        if(rental){   
            recordType_ID.add(Schema.SObjectType.Store_Product__c.getRecordTypeInfosByName().get('Rental').getRecordTypeId());
        }else{            
            recordType_ID.add(Schema.SObjectType.Store_Product__c.getRecordTypeInfosByName().get('Purchasable').getRecordTypeId());
        }                                             
        System.debug(recordType_ID);
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
        
        //declare product list                                             
        List<Store_Product__c> pros = new List <Store_Product__c>();                                           
        
        if(cbFilter.isEmpty()){
            pros = [SELECT Id, Name, Category__c, Rating__c, Price_Per_Unit__c, Star_Rating__c, Product_Description__c, isRental__c,
                    Rental_Start__c, Rental_End__c, RecordTypeId
                    FROM Store_Product__c
                    WHERE Name LIKE : searchkey
                    AND	  Price_Per_Unit__c <= : price
                    AND	  rating__c <= : ratingInt
                    AND   RecordTypeId IN: recordType_ID
                   ];  
        }else{
            pros = [SELECT Id, Name, Category__c, Rating__c, Price_Per_Unit__c, Star_Rating__c, Product_Description__c,isRental__c,
                    Rental_Start__c, Rental_End__c, RecordTypeId 
                    FROM Store_Product__c
                    WHERE Name LIKE : searchkey
                    AND   Category__c IN:cbFilter
                    AND   Price_Per_Unit__c <= : price
                    AND	  rating__c <= : ratingInt
                    AND   RecordTypeId IN: recordType_ID
                   ];            
        }
        System.debug(pros);      
        return pros;
    }
    
}