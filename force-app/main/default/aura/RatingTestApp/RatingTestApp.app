<aura:application >

    <div style="width:350px;">
        <p>Presentation skills:
        	<c:Rating change="{!c.presentationRatingChange}"/>	
        </p>
        <p>Presenter's knowledge:
        	<c:Rating change="{!c.knowledgeRatingChange}" colorOn="#00A1E0" colorOff="#EEEEEE"/>	
        </p>    
        <p>Session organization:
        	<c:Rating change="{!c.organizationRatingChange}" colorOn="#64E000" stroke="#000000" strokeWidth="3"/>
		</p>
    </div>
    
</aura:application>