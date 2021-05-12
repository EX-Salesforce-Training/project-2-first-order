/*    Name: TrendingListController 
     Author: Andreology
     Created: 04/30/2021
     Updated: 05/02/2021
     Description: This page will be a form to receive user input and create web to lead generation
*/
public class TrendingListController extends ItemUiHelper {
    private List<ItemUiHelper> productItemHelper;
    ItemUiHelper uiHelper = new ItemUiHelper();
    public static SelectOption selectedOption {get; set;}
    public String currCat {get; set;}
    Set<SelectOption> categoryOptions = new Set<SelectOption>();
   
    public String GetRow0Col0() {
        return totalProducts[currItem + 1].Product_Description__c;
    }

    public PageReference CheckSelected(){
        System.debug('checking selOption ' + currCat);
        for(SelectOption i : categoryOptions) {
            if(i.getLabel() == currCat) {
                selectedOption = i;
            }
        }
        if(selectedOption!=null){ return  Page.TrendingList; }
        return Page.TrendingList;
    }

    public Set<SelectOption> GetCategoryOptions() {
            Schema.DescribeFieldResult fieldResult = Store_Product__c.Category__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for (Schema.PicklistEntry f: ple) {
                categoryOptions.add(new SelectOption(f.getLabel(), f.getValue()));
            }
        
        return categoryOptions;
    }
    public List<ItemUiHelper> GetProductItemHelper(){
        
        productItemHelper = new List<ItemUiHelper>();
        // check to see if we are on a new instance of the page
        if(currentPage == null){
             totalProducts = [SELECT Name,Id, Price_Per_Unit__c, Rating__c
                               FROM Store_Product__c
                               ORDER BY Rating__c DESC];
            amountOfItems = totalProducts.size();
            
            currentPage = 0;
            totalPages = (amountOfItems/3) + 1;
            SetItemsInGallery();
        } else { SetItemsInGallery(); }

        return productItemHelper;
    }
    public void SetItemsInGallery() {
        boolean column2Flag = true;
        boolean column3Flag = true;
        
        Integer checkItemCount = amountOfItems - (currItem + 1);
        if(checkItemCount==2) { 
            column2Flag = false;
            column3Flag = false;
        }else if(checkItemCount==1) {column3Flag = false;}
            row0Column0 = totalProducts.get(currItem).Name;
            row0Column0Rating = totalProducts.get(currItem).Rating__c;
            row0Column0Price = totalProducts.get(currItem).Price_Per_Unit__c;

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
       
         uiHelper.SaveItemData(row0Column0, row0Column0Price, row0Column0Rating,
                           row0Column1, row0Column1Price, row0Column1Rating,
                           row0Column2, row0Column2Price, row0Column2Rating);
         productItemHelper.add(uiHelper);
    }
    
    
}