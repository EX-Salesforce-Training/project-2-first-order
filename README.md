  -Hello and welcome to the new customer experience site for Party Palace! This repository contains the information for the installation and functionality of the site for the Party Palace party supply retail store. The program itself was created for the Salesforce platform and is composed of Aura Components; written in Apex, JavaScript, HTML, and CSS. An earlier version of the customer experience was written with Visualforce pages; this product has migrated those elements and added a considerable amount of additional functionality. 
  
  
  **Overview**
 - The structure of the site is as a Salesforce Experience site which displays a single ancestral component which contains all the others, the PageMaster.cmp component. 
 
    The PageMaster bundle is responsible for handling the broader layout and alignment of all child components, and accomplishes this by creating a series of diffferent HTML divs with associated CSS classes that handle the positioning. These are housed in the style resource of the bundle, with the html and associated css following the below sample format:
    
   
   

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
  
  
