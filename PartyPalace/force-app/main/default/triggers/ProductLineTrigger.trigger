///////////////////////////////////////////////////////////////////////////
//
// Name: ProductLineTrigger
// Author: Andrew Sutton
// Created 4/10/2021
// Updated 4/11/2021
//
//
/////////////////////////////////////////////////////////////////////////////

trigger ProductLineTrigger on Product_Line__c(before insert, before update, before delete){
    	switch on trigger.operationType{
        when BEFORE_INSERT{
            StoreProductLineTriggerHandler.insertProducts(trigger.new);
        }
        when BEFORE_UPDATE{
            StoreProductLineTriggerHandler.editProducts(trigger.new,trigger.old);
        }
        When BEFORE_DELETE{
            StoreProductLineTriggerHandler.deleteLineItem(trigger.old);
        }
    }
}