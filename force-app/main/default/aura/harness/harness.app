<aura:application extends="force:slds" >
    <aura:attribute name="toRender" type="Boolean" default="false"/>
    <aura:attribute name = "product1" type = "Store_Product__c" 
                    default ="{'Id':'a0C5e000000U8m4EAC', 'Price_Per_Unit__c':20, 'Star_Rating__c':'2.5', 'Rental_End__c' : '', 'Rental_Start__c' : '', 'isRental__c':'true',
                              'Name':'assa id neque aliquam. Non curabitur gravida arcu ac tortor dignissim convallis. In fermentum posuere urna nec tincidunt praesent semper feugiat. Dictumst vestibulum rhoncus est pellentesque. Nec ullamcorper sit amet risus. Sit amet porttitor eget dolor morbi non arcu risus. Sed turpis tincidunt id aliquet risus. Amet nulla facilisi morbi tempus. Risus at ultrices mi tempus imperdiet nulla. Lorem dolor sed viverra ipsum nunc aliquet. Euismod quis viverra nibh cras pulvinar. Arcu vitae elementum curabitur vitae nunc sed.

Eu mi bibendum neque egestas congue quisque. Placerat orci nulla pellentesque dignissim enim sit amet. Nisi lacus sed viverra tellus in Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna', 'Price_Per_Unit__c':20, 'Star_Rating__c':'3.4', 'Product_Description__c':'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Leo vel fringilla est ullamcorper. Suscipit adipiscing bibendum est ultricies integer quis auctor. Nisl condimentum id venenatis a condimentum. Lacus sed turpis tincidunt id aliquet. Arcu non sodales neque sodales ut etiam. Tellus in hac habitasse platea dictumst. Leo urna molestie at elementum eu facilisis sed. Quam vulputate dignissim suspendisse in est ante in nibh. Amet consectetur adipiscing elit ut aliquam purus. Et ligula ullamcorper malesuada proin libero nunc consequat. Aliquam ut porttitor leo a diam.

Porttitor massa id neque aliquam. Non curabitur gravida arcu ac tortor dignissim convallis. In fermentum posuere urna nec tincidunt praesent semper feugiat. Dictumst vestibulum rhoncus est pellentesque. Nec ullamcorper sit amet risus. Sit amet porttitor eget dolor morbi non arcu risus. Sed turpis tincidunt id aliquet risus. Amet nulla facilisi morbi tempus. Risus at ultrices mi tempus imperdiet nulla. Lorem dolor sed viverra ipsum nunc aliquet. Euismod quis viverra nibh cras pulvinar. Arcu vitae elementum curabitur vitae nunc sed.

Eu mi bibendum neque egestas congue quisque. Placerat orci nulla pellentesque dignissim enim sit amet. Nisi lacus sed viverra tellus in hac. Posuere urna nec tincidunt praesent. Nulla facilisi cras fermentum odio eu feugiat pretium nibh ipsum. In nulla posuere sollicitudin aliquam ultrices sagittis orci a. In hac habitasse platea dictumst vestibulum rhoncus est pellentesque elit. Nisl nisi scelerisque eu ultrices vitae. Ornare massa eget egestas purus viverra. Vulputate ut pharetra sit amet aliquam id diam maecenas ultricies. Non nisi est sit amet facilisis magna etiam tempor. Vulputate mi sit amet mauris commodo. Eu non diam phasellus vestibulum lorem sed. Ullamcorper dignissim cras tincidunt lobortis feugiat vivamus at augue. Lorem mollis aliquam ut porttitor leo a diam sollicitudin tempor. Vitae tempus quam pellentesque nec nam aliquam sem. Adipiscing commodo elit at imperdiet dui accumsan sit amet. Id faucibus nisl tincidunt eget nullam.

Gravida rutrum quisque non tellus orci ac auctor augue mauris. Risus nullam eget felis eget nunc lobortis mattis aliquam faucibus. Velit scelerisque in dictum non. Pulvinar etiam non quam lacus. Nunc sed id semper risus in hendrerit. Sociis natoque penatibus et magnis dis. Sit amet nulla facilisi morbi tempus iaculis urna. Erat nam at lectus urna duis. Bibendum est ultricies integer quis auctor elit sed vulputate mi. Donec pretium vulputate sapien nec sagittis aliquam. Ut pharetra sit amet aliquam id. Lacinia at quis risus sed vulputate odio. Nec tincidunt praesent semper feugiat nibh sed.'}"/>
    
    
    <aura:attribute name = "product2" type = "Store_Product__c" 
                    default ="{'Id':'a0C5e000000U8m4EAC',
                              'Name':'Other New Stuff', 'Price_Per_Unit__c':30, 'Star_Rating__c':'5', 'Product_Description__c':'BLAH!','isRental__c':'false',
                              'Rental_End__c' : '', 'Rental_Start__c' : ''}"/>
    
    <c:productDetail userContactID="0035e000003ILKtAAO"/>
    <c:Product product="{!v.product1}" /> 
    <c:Product product="{!v.product2}" />
    <c:starsRate number="3"/>
</aura:application>