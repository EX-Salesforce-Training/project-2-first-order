///////////////////////////////////////////////////////////////
//
// Name: StoreProductsController
// Author: David Serrano, Salesforce Developer
// Created: 05/28/21
// Updated: 05/04/21
// Description: StoreProductsController helps wrap necessary product information and return it to the StoreProductsView. 
// Product information is dependant on the page being displayed, and it has logic to handle navigating through mentioned pages.
//
///////////////////////////////////////////////////////////////

public class StoreProductsController {
    List<ProductsWrapper> productWrapper;
    static Integer currentPage; 
    static Integer totalPages;
    static Id userId = UserInfo.getUserId();
    public String clickedItem {get;set;}
    public Boolean disablePrev {get;set;}
    public Boolean disableNext {get;set;}
    
    // GetProductWrapper is aGetter class to retrieve the product information and display it on the Visualforce Page
    // This only provides data for a 3x5 grid.
    public List<ProductsWrapper> GetProductWrapper(){
        productWrapper = new List<ProductsWrapper>();
        
        // check to see if we are on a new instance of the page
        if(currentPage == null){
            currentPage = 0;
            List<Store_Product__c> pageProducts = [SELECT Name, Id, Price_Per_Unit__c, Product_Description__c FROM Store_Product__c LIMIT 15];
            List<Store_Product__c> totalProducts = [SELECT Name, Id FROM Store_Product__c];        
            totalPages = (totalProducts.size()/15) + 1;
            disablePrev = true;
            
            //render the entire shits
            for(Integer i = 0; i < 5; i++){
                ProductsWrapper pw = new ProductsWrapper();
                String col1 = pageProducts.get(i).Name;
                String col2 = pageProducts.get(i+5).Name;
                String col3 = pageProducts.get(i+10).Name;
                String desc1 = pageProducts.get(i).Product_Description__c;
                String desc2 = pageProducts.get(i+5).Product_Description__c;
                String desc3 = pageProducts.get(i+10).Product_Description__c;
                String price1 = String.valueOf(pageProducts.get(i).Price_Per_Unit__c);
                String price2 = String.valueOf(pageProducts.get(i+5).Price_Per_Unit__c);
                String price3 = String.valueOf(pageProducts.get(i+10).Price_Per_Unit__c);
                
                pw.setProductInfo(col1, col2, col3, desc1, desc2, desc3, price1, price2, price3);
                productWrapper.add(pw);
                
            }
            
            
            
            // load page based on current page
            // current page helps calculate offset
        }else if(currentpage >= 0 || currentPage < totalPages){
            Integer offset = currentPage * 15;
            string s = 'SELECT Name, Id, Product_Description__c, Price_Per_Unit__c FROM Store_Product__c LIMIT 15 OFFSET ' + offset;
            List<Store_Product__c> pageProducts = Database.query(s);
            
            if(currentpage == 0 && currentpage == (totalPages-1)){
                disablePrev = true;
                disableNext = true;
            }else if(currentpage == (totalPages-1)){
                disableNext = true;
                disablePrev = false;
            }else{
                disableNext = false;
                disablePrev = true;
            }
            
            if(pageProducts.size() == 15){
                for(Integer i = 0; i < 5; i++){
                    ProductsWrapper pw = new ProductsWrapper();
                    String col1 = pageProducts.get(i).Name;
                    String col2 = pageProducts.get(i+5).Name;
                    String col3 = pageProducts.get(i+10).Name;
                    String desc1 = pageProducts.get(i).Product_Description__c;
                    String desc2 = pageProducts.get(i+5).Product_Description__c;
                    String desc3 = pageProducts.get(i+10).Product_Description__c;
                    String price1 = String.valueOf(pageProducts.get(i).Price_Per_Unit__c);
                    String price2 = String.valueOf(pageProducts.get(i+5).Price_Per_Unit__c);
                    String price3 = String.valueOf(pageProducts.get(i+10).Price_Per_Unit__c);                    
                    
                    pw.setProductInfo(col1, col2, col3, desc1, desc2, desc3, price1, price2, price3);
                    productWrapper.add(pw);
                    
                }
                
            }else if(pageProducts.size() < 15){
                ProductsWrapper pw = new ProductsWrapper();
                
                for(Integer i = 0; i < pageProducts.size(); i++){
                    for(Integer j = 0; j < 3; j++ ){
                        if(pageProducts[i] != null && pw.name1 == null){
                            pw.name1 = pageProducts[i].Name;
                            pw.desc1 = pageProducts[i].Product_Description__c;
                            pw.price1 = String.valueOf(pageProducts[i].Price_Per_Unit__c);
                            break;

                        }else if(pageProducts[i] != null && pw.name2 == null){
                            pw.name2 = pageProducts[i].Name;
                            pw.desc2 = pageProducts[i].Product_Description__c;
                            pw.price2 = String.valueOf(pageProducts[i].Price_Per_Unit__c);
                            break;
                            
                        }else if(pageProducts[i] != null && pw.name3 == null){
                            pw.name3 = pageProducts[i].Name;
                            pw.desc3 = pageProducts[i].Product_Description__c;
                            pw.price3 = String.valueOf(pageProducts[i].Price_Per_Unit__c);
                            productWrapper.add(pw);
                            pw = new ProductsWrapper();
                            break;
                            
                        }
                    }
                }
                
                if(pw.name1 != null){
                    productWrapper.add(pw);
                }
                
            }
            
        }

        return productWrapper;
    }
    
    
    // ProductsWrapper
    public class ProductsWrapper{
        public String name1{get;set;}
        public String name2{get;set;}
        public String name3{get;set;}
        public String desc1{get;set;}
        public String desc2{get;set;}
        public String desc3{get;set;}
        public String price1{get;set;}
        public String price2{get;set;}
        public String price3{get;set;}
        
        public void setProductInfo(String col1, string col2, String col3, String desc1, String desc2, String desc3, String price1, String price2, String price3){
          	this.name1 = col1;
            this.name2 = col2;
            this.name3 = col3;
            this.desc1 = desc1;
            this.desc2 = desc2;
            this.desc3 = desc3;
            this.price1 = price1;
            this.price2 = price2;
            this.price3 = price3;
        }
        
    }

    // Next
    public PageReference next(){
  
        if((currentPage+1) < totalPages){
            currentPage++;
            return Page.StoreProductsView;
            
        }
        
        return Page.StoreProductsView;
        
    }
    
    // Prev
    public PageReference prev(){
        
        if((currentPage-1) >= 0){
            currentPage--;
            return Page.StoreProductsView;
            
        }
        
        return Page.StoreProductsView;
       
    }
    
    // AddToCart
    public void AddToCart(){

        User currentUser = [Select ContactID FROM User WHERE Id =: userId];
        Transaction__c trans = [SELECT Name, Contact__c FROM Transaction__c WHERE Status__c='Active' AND Contact__c =: currentUser.ContactId];
        //Transaction__c trans = [SELECT Id FROM Transaction__c WHERE Status__c='Active'];
        Store_Product__c product = [SELECT Id FROM Store_Product__c WHERE Name =: clickedItem];
        Product_Line__c productLine = new Product_Line__c(Product__c=product.id, Transaction__c=trans.id, Quantity__c=1);
        insert productLine;
        
    }
}