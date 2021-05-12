<aura:application extends="force:slds">
    <div id = "page-container">
        <div id = "page-header">
            <h1 class = "slds-text-heading_large slds-align_absolute-center">Party Palace</h1>
        </div>
        <div class="side-bar">
        </div>
        <div id = "product-view">
            <c:ProductList />
            <c:TrendingItems />
        </div>
        <div class="side-bar">
        </div>
    </div>
</aura:application>