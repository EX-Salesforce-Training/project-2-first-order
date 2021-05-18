  -Hello and welcome to the new customer experience site for Party Palace! This repository contains the information for the installation and functionality of the site for the Party Palace party supply retail store. The program itself was created for the Salesforce platform and is composed of Aura Components; written in Apex, JavaScript, HTML, and CSS. An earlier version of the customer experience was written with Visualforce pages; this product has migrated those elements and added a considerable amount of additional functionality. 
  
  
  
  
  
  **Overview & Top Level Components**
 - The structure of the site is as a Salesforce Experience site which displays a single ancestral component which contains all the others, the PageMaster.cmp component. 
 
    The PageMaster bundle is responsible for handling the broader layout and alignment of all child components, and accomplishes this by creating a series of diffferent HTML divs with associated CSS classes that handle the positioning. These are housed in the style resource of the bundle, with the html and associated css following the below sample format:
    
   
   ```

    <div class="side-bar">
        <div class = "side-bar-content-holder">
            <c:ShoppingCart/>
        </div>
    </div>

  ```
   

   .THIS .side-bar-content-holder {
    border-radius: 5px;
    background: white;
    padding: 1em;
    height: 100%;
    }

  ```
  
  The client-side controller of the PageMaster component uses java script to select individual divs and alter their size, alignment, and visibility based on certain criteria
  i.e. - if a user clicks a button, then display a component. It accomplishes this chiefly through using the format of using querySelector to isolate specific divs, then using the .classList.add or remove js method. The classes modify the visibility of the properties. There are many variations on this theme through the broader program. An example below:
  
  ```
turnOnDetails : function(component, event, helper) {
        
        //Jump to top of the container
        var top = document.querySelector("#content-container").getBoundingClientRect().top;
        window.scrollTo(window.pageXOffset, window.pageYOffset + top);
        
        //Retrieve the list and detail containers
		let pList = document.querySelector("#productlist");
        let dList = document.querySelector("#productview");
        
        //If the list is on swap
        if(component.get("v.pListOn")) {
            pList.classList.add("hide");
            setTimeout(() => { 
       			dList.classList.remove("hidden");
                dList.classList.remove("hide");
        		dList.classList.add("shown");
            	component.set("v.dListOn", true);
            }, 500);
        }
         
        //If the list is off, just show the details
        else {
            component.set("v.dListOn", true);
        	dList.classList.remove("hidden");
        	dList.classList.remove("hide");
        	dList.classList.add("shown");    
        }
	}
        
 ```
**Finding a product**
A key part of this Party Palace customer experience portal is the ability to easily search through the types of products and rentals available to them without having to manually examine every single type of item to find what they want. In the center of the initial view of the page is a trending items component, which directs users to examine items that have the highest overall values for the Star_Rating__c field of the product object. This is retrieved by the TopListController.cls, an Apex controller written for this purpose.
The source code for this controller is displayed below; a simple SOQL query wrapped in an @auraenabled method to make it available to the client controller.
```
public class TopListController {
	
    @AuraEnabled
    public static List<Store_Product__c> GetProducts() {

        return [SELECT Id, Name, Category__c, Rating__c, Price_Per_Unit__c, 
                Star_Rating__c, Product_Description__c, Rental_Start__c, Rental_End__c 
                FROM Store_Product__c ORDER BY Star_Rating__c DESC LIMIT 10];
    }
}

```
Customers are also able to make use of the robust Search Bar section of the site to use filters and underlying keyword logic to find both individual items and categories of items. The Search Bar component 
















****
