/*    Name: TrendingListController 
     Author: Andreology
     Created: 04/30/2021
     Updated: 05/02/2021
     Description: Controller class for TrendingList VisualForce Page. Includes functionality to 
                execute pagination for Party Palace Store Items and for setting up interface variables.
*/
public class TrendingListController extends ItemUiHelper {
    public List<ItemUiHelper> productItemHelper;
    ItemUiHelper uiHelper = new ItemUiHelper();

    //Method to Generate page setup and save list of poducts currently in org. 
    public List<ItemUiHelper> GetProductItemHelper(){
        productItemHelper = new List<ItemUiHelper>();
        // Verify if page in new
        if(currentPage == null){
            //query for Party Palace Items and order by rating
             totalProducts = [SELECT Name,Id, Price_Per_Unit__c, Rating__c
                               FROM Store_Product__c
                               ORDER BY Rating__c DESC];
            amountOfItems = totalProducts.size();
            currentPage = 0;
            totalPages = (amountOfItems/3) + 1;
            SetItemsInGallery();
            //if page is already created just bind variables to VF atttributes
        } else { SetItemsInGallery(); }

        return productItemHelper;
    }
    public void SetItemsInGallery() {
        boolean column2Flag = true;
        boolean column3Flag = true;
        //Assign Store Product Items to Grid which will hold 3 items only and no limit. 
        Integer checkItemCount = amountOfItems - (currItem + 1);
        if(checkItemCount==2) { 
            column2Flag = false;
            column3Flag = false;
        }else if(checkItemCount==1) {column3Flag = false;}
            row0Column0 = totalProducts.get(currItem).Name;
            row0Column0Rating = totalProducts.get(currItem).Rating__c;
            row0Column0Price = totalProducts.get(currItem).Price_Per_Unit__c;
        //check flags to see if items left relative to current item in list is 2 or 3
        //if 2 or 1 items are left, then set item pointer to beginning of list
        if(column2Flag && column3Flag) { 
            row0Column1 = totalProducts.get(currItem + 1).Name;
            row0Column1Rating = totalProducts.get(currItem + 1).Rating__c;
            row0Column1Price = totalProducts.get(currItem + 1).Price_Per_Unit__c;
            row0Column2 = totalProducts.get(currItem + 2).Name;
            row0Column2Rating = totalProducts.get(currItem + 2).Rating__c;
            row0Column2Price = totalProducts.get(currItem + 2).Price_Per_Unit__c;
        }else if(column2Flag && column3Flag == false) {
            row0Column1 = totalProducts.get(currItem + 1).Name;
            row0Column2 = totalProducts.get(0).Name;
            currItem = 0;
        }else if(column2flag == false && column3Flag == false){
            row0Column1 = totalProducts.get(0).Name;
            row0Column2 = totalProducts.get(1).Name;
            currItem = 1;
        }
        //save data for items in grid gallery
         uiHelper.SaveItemData(row0Column0, row0Column0Price, row0Column0Rating,
                           row0Column1, row0Column1Price, row0Column1Rating,
                           row0Column2, row0Column2Price, row0Column2Rating);
         productItemHelper.add(uiHelper);
    }    
}