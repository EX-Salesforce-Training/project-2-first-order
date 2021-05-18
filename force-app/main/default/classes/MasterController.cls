public class MasterController {
	
    @AuraEnabled
    public static String GetCurrentCID() {
        Id userId = UserInfo.getUserId();
        String cId = [SELECT contactId FROM User WHERE Id = :userId].contactId;
        return cId;
    }
}