///////////////////////////////////////////////////////////////////////////
//
// Name: DeliveryTriggerTest
// Author: Andrew Sutton
// Created 4/10/2021
// Updated 4/14/2021
//
//
/////////////////////////////////////////////////////////////////////////////

@istest
public class DeliveryTriggerTest {
    @isTest static void singleTest(){
        Installer__c ins = new Installer__c(name = 'chad');
        insert ins;
        Rental__c rent = new Rental__c(name = 'house', Price_Per_Unit__c = 2);
        insert rent;
        Rental__c rent2 = new Rental__c(name = 'chair', Price_Per_Unit__c = 1);
        insert rent2;
        Transaction__c trans = new Transaction__c();
        insert trans;
        Contact contact = new Contact(LastName = 'test');
        insert contact;
        Date myDate = Date.newInstance(1960, 2, 17);
        Delivery__c del = new Delivery__c(Contact__c = contact.id, Installer__c = ins.id, Delivery_Date__c = myDate, Rental_Period__c = '24 Hour');
        insert del;
        Rental_Line__c rental1 = new Rental_Line__c(Transaction__c = trans.id, Rental__c = rent.id, Delivery__c = del.Id, Quantity__c = 1);
        insert rental1;
        Rental_Line__C rental2 = new Rental_Line__c(Transaction__c = trans.id, Rental__c = rent2.id, Delivery__c = del.Id, Quantity__c = 1);
        insert rental2;
        rental2.Quantity__c = 2;
        update rental2;
        del.Delivered__c = true;
        update del;

    }
}