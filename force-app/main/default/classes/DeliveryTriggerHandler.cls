///////////////////////////////////////////////////////////////////////////
//
// Name: DelvieryTriggerHandler
// Author: Andrew Sutton
// Created 4/10/2021
// Updated 4/14/2021
//
//
/////////////////////////////////////////////////////////////////////////////

public class DeliveryTriggerHandler {
    public static void createDelivery(List<Delivery__c> Deliveries){
        For(Delivery__c d:Deliveries){
            checkForDelivery(d);
        }
        setRentalPeriod(Deliveries);
        
    }
    public static void updateDelivery(List<Delivery__c> DeliveriesNew, List<Delivery__c> DeliveriesOld){
        For(Delivery__c d:DeliveriesOld){
            checkForDelivery(d);
        }
        setRentalPeriod(DeliveriesNew);
    }
    public static void checkForDelivery(Delivery__c Delivery){
        if (Delivery.Delivered__c){
            Delivery.addError('Already Delivered, cannot make any changes');
        }
        
    }
    public static void setRentalPeriod(List<Delivery__c> Deliveries){
        set<id> instID = new set<id>();
        for(Delivery__c d:Deliveries){
            instID.add(d.Installer__c);
        }
        set<id> deliveryID = new set<id>();
        for(Delivery__c d: Deliveries){
            deliveryID.add(d.id);
        }
        List<Installer__c> installers = [SELECT name FROM Installer__c WHERE ID =: instID];
        List<Rental_Line__c> Rentals = [SELECT name, Rental__c FROM Rental_Line__c WHERE Delivery__c =: deliveryID];
        List<Rental_Period__c> newRentalPeriods = new List<Rental_Period__c>();
        For(Delivery__c d:Deliveries){
            if (d.Delivered__c){
                For(Rental_Line__c rentalLine : Rentals){
                    For(Installer__c ins: installers){
                        Rental_Period__c rentalPeriod = new Rental_Period__c(Rental__c = rentalLine.Rental__c, Installer__c = ins.Id);
                        rentalPeriod.Start_Date__c = d.Delivery_Date__c;
                        if(d.Delivery_Date__c == null){
                            d.Delivery_Date__c = date.today();
                        }
                        Switch on d.Rental_Period__c{
                            when '24 Hour'{
                                rentalPeriod.End_Date__c = d.Delivery_Date__c + 1;
                            }
                            when '48 Hour'{
                                rentalPeriod.End_Date__c = d.Delivery_Date__c + 2;
                            }
                        }
                        newRentalPeriods.add(rentalPeriod);
                    }
                }
            }
        }
        if(!newRentalPeriods.isEmpty()){
        	Insert newRentalPeriods;
        }
    }
}