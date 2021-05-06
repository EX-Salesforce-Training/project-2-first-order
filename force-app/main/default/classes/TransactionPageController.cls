///////////////////////////////////////////////////////////////////////////
//
// Name: TransactionPageController
// Author: Andrew Sutton
// Created 5/4/2021
// Updated 5/4/2021
//
//
/////////////////////////////////////////////////////////////////////////////

public class TransactionPageController {
    public Transaction__c trans{get;set;}
    public List<Product_Line__c> productLines{get;set;}
    Id currentUser = UserInfo.getUserId();
    CurrentTransaction currentTrans = new CurrentTransaction();
    public List<String> TotalCost {get;set;}
    public string GrandTotal {get;set;}
    
    public TransactionPageController(){
        //currentTrans will query take the current user and get the active transaction assciated with that user
        trans = currentTrans.Trans;
        //get the product lines with the current transaction as their parent
        productLines = [SELECT Name, Transaction__c, Product__c, Quantity__c, Total_Cost__c FROM Product_Line__c WHERE Transaction__c =: trans.id];
        //This for loop is to get the total cost as a string so we can display it
        TotalCost = new List<String>();
        for (Product_Line__c pl : productLines){
      		String tc = String.valueOf(pl.Total_Cost__c);
            TotalCost.add(tc);
        }
        //Also needed to so the grand total will display
		GrandTotal = String.valueOf(trans.Total_Cost__c);
    }
    

    public PageReference save(){
        trans.Status__c = 'Closed';
        //Creating a new transaction with the status of Active after closing the old one
        Transaction__c newTransaction = new Transaction__c(Contact__c = trans.Contact__c, Store_Location__c = trans.Store_Location__c, Salesperson__c = trans.Salesperson__c, Status__c = 'Active');
        update trans;
        insert newTransaction;
        //now setting our trans to the new one
        trans = newTransaction;
        //the rest of the code is needed to rerender the page on click with the updated info, so re-calling everything
        currentTrans.setCurrentTransaction(newTransaction);
        productLines = [SELECT Name, Transaction__c, Product__c, Quantity__c FROM Product_Line__c WHERE Transaction__c =: newTransaction.id];
        TotalCost = new List<String>();
        for (Product_Line__c pl : productLines){
      		String tc = String.valueOf(pl.Total_Cost__c);
            TotalCost.add(tc);
        }
        GrandTotal = String.valueOf(trans.Total_Cost__c);
        return Page.TransactionPage;
    }
    public PageReference updatePage(){
        //because of outputfield with inline support, just updates the database
        upsert productLines;
        //re-calling everything for the rerender so the info is correct
        currentTrans = new CurrentTransaction();
        trans = currentTrans.Trans;
        productLines = [SELECT Name, Transaction__c, Product__c, Quantity__c, Total_Cost__c FROM Product_Line__c WHERE Transaction__c =: trans.id];
        TotalCost = new List<String>();
        for (Product_Line__c pl : productLines){
      		String tc = String.valueOf(pl.Total_Cost__c);
            TotalCost.add(tc);
        }
        GrandTotal = String.valueOf(trans.Total_Cost__c);
        return Page.TransactionPage;
    }

    }