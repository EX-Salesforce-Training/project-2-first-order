@isTest(SeeAllData = True)
public class TransactionPageControllerTest {
    @isTest static void singleTest(){
        User user = [SELECT name FROM User WHERE name =: 'Andy Young'];
        System.runAs(user){
            TransactionPageController x = new TransactionPageController();
            x.save();
        }
    }
}