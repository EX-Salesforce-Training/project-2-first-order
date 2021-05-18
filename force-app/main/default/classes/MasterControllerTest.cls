@isTest
public class MasterControllerTest {

    @testSetup
    public static void setupTests() {
        Account a = new Account(Name = 'Test Account Name');
  		insert a;
 
        Contact newCon = new Contact(LastName = 'The Tester2', AccountId = a.id);
        insert newCon;
        Profile custPro = [SELECT id FROM profile WHERE name = 'Test ccu'];
        User customer = new User(LastName = 'user23232', 
                                 Username = 'user23.2@sfdc.com', 
                                 Email = 'usersf22132@gmail.com', 
                                 Alias = 'test22', 
                                 Phone = '00000000003',
                                 TimeZoneSidKey = 'GMT', 
                                 LocaleSidKey = 'en_GB', 
                                 EmailEncodingKey = 'ISO-8859-1', 
                                 ProfileId = custPro.id, 
                                 LanguageLocaleKey = 'en_US',
                                 contactID = newCon.Id,
                                 IsActive = true,
                                 CommunityNickname = 'testUser232'); 
        
        Insert(customer);
    }
    
    @isTest
    public static void TP_GetCurrentCID() {
        User expectedUser = [SELECT contactId FROM User WHERE LastName = 'user23232' LIMIT 1];
        
        System.runAs(expectedUser) {
            System.assertEquals('' + expectedUser.contactId, MasterController.GetCurrentCID());
        }
        
    }
}