///////////////////////////////////////////////////////////////////////////
//
// Name: StoreProductLineTest
// Author: Andrew Sutton
// Created 4/10/2021
// Updated 4/14/2021
//
//
/////////////////////////////////////////////////////////////////////////////


@istest
private class StoreProductLineTest {
	@isTest static void singleTest(){
        Store_Location__c loc = new Store_Location__c(name = 'NY');
        insert loc;
        Store_Product__c prod = new Store_Product__c(name = 'Hat', Price_Per_Unit__c = 3);
        insert prod;
        Salesperson__c chad = new Salesperson__c(Store_Location__c = loc.id);
        insert chad;
        Store_Inventory__c inv = new Store_Inventory__c(Store_Location__c = loc.id, Store_Product__c = prod.id, Number_in_Stock__c = 100);
        insert inv;
        Transaction__c trans = new Transaction__c(Store_Location__c = loc.id, Salesperson__c = chad.id);
        insert trans;
        Product_Line__c line = new Product_Line__c(Transaction__c = trans.id, Product__c = prod.id, Quantity__c = 10);
       	insert line;
       	Product_Line__c line2 = new Product_Line__c(Transaction__c = trans.id, Product__c = prod.id, Quantity__c = 101);
        line.Quantity__c = 101;
        Integer numFailed = 0;
        Database.SaveResult sr = Database.insert(line2, false);
        if(!sr.isSuccess()){
            numFailed = 1;
        }
        Database.SaveResult sr2 = Database.update(line, false);
        if(!sr.isSuccess()){
            numFailed = 2;
        }
        System.assertEquals(2, numFailed);
        delete line;
    }
    
    
    
}