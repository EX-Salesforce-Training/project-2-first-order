///////////////////////////////////////////////////////////////////////////
//
// Name: RentalLineTrigger
// Author: Andrew Sutton
// Created 4/10/2021
// Updated 4/11/2021
//
//
/////////////////////////////////////////////////////////////////////////////


trigger RentalLineTrigger on Rental_Line__c (before insert, before update) {
    switch on trigger.operationType{
	when BEFORE_INSERT{
            RentalLineTriggerHandler.executeInsert(trigger.new);
        }
        when BEFORE_UPDATE{
            RentalLineTriggerHandler.updateTotalCost(trigger.new);
        }
       
    }
}