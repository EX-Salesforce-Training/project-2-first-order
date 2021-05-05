///////////////////////////////////////////////////////////////////////////
//
// Name: RentalLineTriggerHandler
// Author: Andrew Sutton
// Created 4/10/2021
// Updated 4/12/2021
//
//
/////////////////////////////////////////////////////////////////////////////


public class RentalLineTriggerHandler {
    public static void executeInsert(List<Rental_Line__c> newRentals){
        updateInventory(newRentals);
        updateTotalCost(newRentals);
        
    }
    
    public static void updateTotalCost(List<Rental_Line__c> newRentals)
    {
        List<Rental__c> Rentals = [SELECT Price_Per_Unit__c FROM Rental__c];
        for (Rental_Line__c rl: newRentals){
            for(Rental__c r: Rentals){
                if(rl.Rental__c == r.id){
                    rl.Total_Cost__c = r.Price_Per_Unit__c * rl.Quantity__c;
                }
                
            }
        }        
    }
    public static void updateInventory(List<Rental_Line__c> RentalLine){
        List<Rental_Inventory__c> inventories = findInventory(RentalLine);
        For(Rental_Line__c rl: RentalLine){
            For(Rental_Inventory__c inventory:inventories){
                //subtract From Inventory
                inventory.Quantity_in_Stock__c = inventory.Quantity_in_Stock__c - rl.Quantity__c;
                //Ask if we are out of stock
                if (inventory.Quantity_in_Stock__c < 0){
                    rl.Quantity__c.addError('Not enough in Stock');
                }
            }
        }
        update inventories;
    }
    static List<Rental_Inventory__c> findInventory(List<Rental_Line__c> RentalLines)
    {
        Set<id> transid = new set<id>();
        for(Rental_Line__c rl :RentalLines){
            transid.add(rl.Transaction__c);
        }
        Set<id> rentalId = new set<id>();
        for(Rental_Line__c rl : RentalLines){
            rentalID.add(rl.rental__c);
        }
        //Grab the transactions that matches our Rental Line item's transactions
        List<Transaction__c> trans = [SELECT Warehouse__c FROM Transaction__c WHERE id = : TransID];
        set<id> locationID = new set<id>();
        for(Transaction__c tran : trans){
            locationID.add(tran.Warehouse__c);
        }
        List<Rental_Inventory__c> inventory = [SELECT Quantity_in_Stock__c, Rental__c FROM Rental_Inventory__c WHERE Rental__c IN :rentalID AND Warehouse__c =: locationID];
        return inventory;
    }    
    
    
    
}