///////////////////////////////////////////////////////////////////////////
//
// Name: StoreProductLineTriggerHandler
// Author: Andrew Sutton
// Created 4/10/2021
// Updated 4/14/2021
//
//
/////////////////////////////////////////////////////////////////////////////
public class StoreProductLineTriggerHandler {
    public static void insertProducts(List<Product_Line__c> newProducts) {
        updateInventory(newProducts);
        updateTotalCost(newProducts);
        
    }
    public static void updateInventory(List<Product_Line__c> newProducts){   
        List<Store_Inventory__c> inventories = findInventory(newProducts);    
        For(Product_Line__c pl: newProducts){
            For(Store_Inventory__c inventory:inventories){
            //subtract From Inventory
            inventory.Number_in_Stock__c = inventory.Number_in_Stock__c - pl.Quantity__c;
            //Ask if we are out of stock
            if (inventory.Number_in_Stock__c < 0){
                pl.Quantity__c.addError('Not enough in Stock');
            }
        }
        }
        update inventories;
        
    }
    public static void updateTotalCost(List<Product_Line__c> newProductLines)
    {
        List<Store_Product__c> Products = [SELECT Price_Per_Unit__c FROM Store_Product__c];
        for (Product_Line__c pl: newProductLines){
            for(Store_Product__c p: products){
                if(pl.Product__c == p.id){
                    pl.Total_Cost__c = p.Price_Per_Unit__c * pl.Quantity__c;
                }
                
            }
        }
    }
    public static void editProducts(List<Product_Line__c> newProducts, List<Product_Line__c> oldProducts){
        List<Store_Inventory__c> oldInvs = findInventory(oldProducts);
        List<Store_Inventory__c> newInvs = findInventory(newProducts);
        //get the difference in inventory from old to new
        //for(Integer i = 0; i < newProducts.size(); i++){
        //newInvs[i].Number_in_Stock__c = newInvs[i].Number_in_Stock__c - (newProducts[i].Quantity__c - oldProducts[i].Quantity__c);
        //Ask if we are out of stock
        //if (newInvs[i].Number_in_Stock__c < 0){
        //    newProducts[i].Quantity__c.addError('Not enough in Stock');
        //}
        //}
        update newInvs;
        updateTotalCost(newProducts);
        
        
    }
    
    public static void deleteLineItem(List<Product_Line__c> newProducts){
        List<Store_Inventory__c> inventory = findInventory(newProducts);
        For(Product_Line__c pl: newProducts){
            //add the quantity back to the inventory
            //inventory.Number_in_Stock__c = inventory.Number_in_Stock__c + pl.Quantity__c;   
        }
        update inventory;
    }
    static List<Store_Inventory__c> findInventory(List<Product_Line__c> newProducts)
    {
        Set<id> transid = new set<id>();
        for(Product_Line__c pl :newProducts){
            transid.add(pl.Transaction__c);
        }
        Set<id> productId = new set<id>();
        for(Product_Line__c pl : newProducts){
            productID.add(pl.product__c);
        }
        //Grab the transactions that matches our Product Line item's transactions
        List<Transaction__c> trans = [SELECT Store_Location__c FROM Transaction__c WHERE id = : TransID];
        set<id> locationID = new set<id>();
        for(Transaction__c tran : trans){
            locationID.add(tran.Store_Location__c);
        }
        List<Store_Inventory__c> inventory = [SELECT Number_in_Stock__c, Store_Product__c FROM Store_Inventory__c WHERE Store_Product__c IN :productID AND Store_Location__c =: locationID];
        return inventory;
    }    

}