public class ShoppingCartApexController {
    @AuraEnabled
    public static double savePurchase(Store_Product__c [] products, Integer [] quantity, String contactID ){
        String [] products, Integer [] quantity
        
        List <PurchasedProduct__c> myList = new List <PurchasedProduct__c> ();
        Integer num = quantity [0];
        Store_Product__c product = products [0]; 
   
        double totalAmount =0;
        
        // Getting Contact ID
       for (TypeofParse ctId: contactParse){
            Purchase__c purNum = new Purchase__c(contact__c=ctId.id);
      }
     // Create new Purchase Number 
	insert purNum;
        
 
        
        
        for (integer j =0; j<=quantity.length;j++){
            for (integer i = 0; i<=quantity[j]; i++){

					for (Store_Product__c pro: products[j]){
            			PurchasedProduct__c myproduct = new PurchasedProduct__c(Store_Product__c=pro.id, Purchase__c=purNum.id);
						myList.add(myproduct) ;
						totalAmount+=pro.Price_per_unit__c;
					}
   
			}
        }
        
		
		insert myList;
        
        return totalAmount;
    }
}