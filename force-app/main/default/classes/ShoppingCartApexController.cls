public class ShoppingCartApexController {
    @AuraEnabled
    public static void savePurchase(Product_Line__c[] prodList, String contactID){
        
        
        Transaction__c transa = new Transaction__c(contact__c=contactId);
        insert transa;
        
        for(Product_Line__c line: prodList){
            line.transaction__c = transa.Id;
        }
        insert prodList;
        
    }
    
}