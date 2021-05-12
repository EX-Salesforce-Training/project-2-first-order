<aura:application extends="force:slds" >
    <aura:attribute name="toRender" type="Boolean"/>
    <aura:attribute name = "product1" type = "Store_Product__c" 
                    default ="{'Id':'a0C5e000000U8m4EAC',
                              'Name':'New stuff', 'Price_Per_Unit__c':20, 'Star_Rating__c':'3.4', 'Product_Description__c':'blah blah'}"/>
    <aura:attribute name = "product2" type = "Store_Product__c" 
                    default ="{'Id':'a0C5e000000U8m4EAC',
                              'Name':'Other New Stuff', 'Price_Per_Unit__c':30, 'Star_Rating__c':'4.5', 'Product_Description__c':'BLAH!'}"/>
    <c:productDetail />
    <c:Product product="{!v.product1}"/> 
    <c:Product product="{!v.product2}"/>
    <c:starsRate number="3"/>
</aura:application>