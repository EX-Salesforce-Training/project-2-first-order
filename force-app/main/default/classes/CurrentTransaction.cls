public class CurrentTransaction {
    public Transaction__c Trans{get;set;}
    Id currentUser = UserInfo.getUserId();
    public CurrentTransaction(){
        User you = [SELECT Name, ContactID FROM User where id =: currentUser];
        trans = [SELECT Name, Contact__c, Status__c, Store_Location__c, Total_Cost__c, Salesperson__c FROM Transaction__c WHERE Status__c =: 'Active' AND Contact__c =: you.ContactId];
    }
    public void setCurrentTransaction(Transaction__c newTransaction){
        trans = newTransaction;
    }
}