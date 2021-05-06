///////////////////////////////////////////////////////////////////////////
//
// Name: DeliveryTrigger
// Author: Andrew Sutton
// Created 4/10/2021
// Updated 4/11/2021
//
/////////////////////////////////////////////////////////////////////////////


trigger DeliveryTrigger on Delivery__c (before insert, before update) {
    switch on trigger.operationType{
	when BEFORE_INSERT{
            DeliveryTriggerHandler.CreateDelivery(trigger.new);
        }
        when BEFORE_UPDATE{
            DeliveryTriggerHandler.UpdateDelivery(trigger.new, trigger.old);
        }
        
    }

}