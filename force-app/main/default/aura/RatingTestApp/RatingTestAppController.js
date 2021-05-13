({
	knowledgeRatingChange : function(component, event, helper) {
        alert("Presenter's knowledge: " + event.getParam("rating"));
	},
	presentationRatingChange : function(component, event, helper) {
        alert("Presentation Skills: " + event.getParam("rating"));
	},
	organizationRatingChange : function(component, event, helper) {
        alert("Session Organization: " + event.getParam("rating"));
	},
})