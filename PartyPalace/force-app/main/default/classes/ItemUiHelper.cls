/*    Name: Helper class that may be extended
     Author: Andreology
     Created: 04/30/2021
     Updated: 05/02/2021
     Description: This Helper class is a parent to TrendingListController. It enables pagination support. 
                  i.e. providing functions for next and previous page for trending items gallery
*/
virtual public class ItemUiHelper{
    public Integer currItem = 0;
    public List<Store_Product__c> totalProducts {get; set;}
    public Integer amountOfItems = 0;
    //row0colums' are used to save data related to current 3 items in VF view
    public String row0Column0{get;set;}
    public String row0Column1{get;set;}
    public String row0Column2{get;set;}
    
    public Decimal row0Column0Rating{get;set;}
    public Decimal row0Column1Rating{get;set;}
    public Decimal row0Column2Rating{get;set;}

    public Decimal row0Column0Price{get;set;}
    public Decimal row0Column1Price{get;set;}
    public Decimal row0Column2Price{get;set;}

    public Store_Product__c currentItem;
    public static Integer currentPage = null;
    public static Integer totalPages {get; set;}
    //Contstructor to hold current product item in store being worked on 
    public ItemUiHelper(){
        currentItem = new Store_Product__c();
    }   
    //Function to assign pointer to next item in list
    //if end of list is reached pointer is set to beginning of list
    public PageReference ShowNextProducts(){
        System.debug('callingnext()');
        if(amountOfItems == (currItem + 1)) {
            currItem = 0;
        }
        if((currentPage+1) < totalPages){
            currentPage = currentPage + 1;
        }
        currItem = currItem  + 3;
        return Page.TrendingList;
    }
    // method to show previous items
    public PageReference ShowPreviousProducts(){
        
        if((currentPage-1) >= 0){
          currentPage = currentPage - 1;
        }
        currItem = currItem  - 3;
    
        return Page.TrendingList;
    }
    //method to save data from org related to each store product item
    public void SaveItemData(String row0Column0, Decimal row0Column0Price, Decimal  row0Column0Rating,
                               String row0Column1, Decimal row0Column1Price, Decimal row0Column1Rating,
                               String row0Column2, Decimal row0Column2Price, Decimal row0Column2Rating){
        this.row0Column2 = row0Column2;
        this.row0Column1 = row0Column1;
    	this.row0Column0 = row0Column0;
        this.row0Column2Price = row0Column2Price;
        this.row0Column1Price = row0Column1Price;
    	this.row0Column0Price = row0Column0Price;
        this.row0Column2Rating = row0Column2Rating;
        this.row0Column1Rating = row0Column1Rating;
    	this.row0Column0Rating = row0Column0Rating;
       
        this.currentItem.id = currentItem.Id;
    }  
    
}