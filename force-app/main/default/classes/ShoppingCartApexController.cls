public class ShoppingCartApexController {
    @AuraEnabled
    public static void savePurchase(List<Store_Product__c> storeProdList, List<Product_Line__c> prodList, String contactID){
        Transaction__c transa = new Transaction__c(contact__c=contactID);
        try{
        	insert transa;
        } catch(exception e){
            system.debug(e);
        }
        
        List<Product_Line__c> createProList = new List<Product_Line__c>();
        
        for(Integer i = 0; i < prodList.size(); i++){
            Product_line__c tempProd = new Product_line__c();
            tempProd.Quantity__c = prodList.get(i).Quantity__c;
            tempProd.Product__c = storeProdList.get(i).Id;
            tempProd.Transaction__c = transa.Id;
            createProList.add(tempProd);
        }
        insert createProList;
        
    }
    
}