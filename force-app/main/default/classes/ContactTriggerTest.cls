// all test classes must be annotated with @isTest and be either public or private
// additionally, it's a good idea to name our test class after the class/feature it's testing, e.g. ContactTriggerTest for
// our trigger named ContactTrigger
@isTest
private class ContactTriggerTest {
    // our testing best practices include testing for positive, negative, and single cases
    // all of which we do in the following test method
    
    // our test methods must also have the @isTest annotation, as well as having no parameters and being static and void
    @isTest static void singleTest(){
        // by default, our test methods don't have access to production data
        // testing against production data is a bad practice anyway, so we create our own test data
        // test data is temporary - it only lasts for the duration of the test method and is never fully committed to the database
        Contact c = new Contact(LastName='Test', Email='test@test.com');
        // because we're testing a trigger, we don't directly call it - our trigger is tied to the contact object so it'll fire
        // as soon as we insert a new contact 
        
        // because there are no other records that our test method can see, our trigger should be fine with us inserting a non-
        // duplicate contact
        // in this case, we're testing for negative behavior - when our trigger gets something it shouldn't act on (i.e. a non-
        // duplicate contact), does it ignore it as it should?
        insert c;
        
        Contact c2 = new Contact(LastName='Test 2', Email='test@test.com');
        
        // in addition to allowing partial completion, the Database.insert method returns an instance of the Database.SaveResult
        // class for each record
        Database.SaveResult sr = Database.insert(c2, false);
        Integer numFailed = 0;
        // one of the methods of Database.SaveResult is isSuccess(), which tells us if the DML operation was successful for that
        // particular record
        // we inserted a duplicate contact record, so we're expecting our trigger to block that record from being saved -
        // we're testing for positive behavior
        if(!sr.isSuccess()){
            numFailed = 1;
        }
        // the System class has a variety of methods that are useful for testing, one of these methods is System.assertEquals()
        // we pass an expected value (1 in this case) and the actual value (numFailed) to this method; if the valeus are equal,
        // our test will pass. if not, it will fail
        System.assertEquals(1, numFailed);
    }
    
    // another testing best practice is to test for bulk behavior
    // generally, this means that we want to test on more than 150 records (at least) to ensure that all SOQL queries/DML statements
    // are outside of for loops and won't violate governor limits by being invoked too many times
    @isTest static void bulkTest(){
        List<Contact> testCons = new List<Contact>();
        List<Contact> duplicateCons = new List<Contact>();
        for(Integer i = 0; i < 295; i++){
            if(i < 195){
            	testCons.add(new Contact(LastName='Test ' + i, Email='test' + i + '@test.com'));
            }
            else{
                duplicateCons.add(new Contact(LastName='Test ' + i, Email='test0@test.com'));
            }
        }
        insert testCons;

        // all 100 of these contacts are duplicates, so we should have 100 failures - failing successfully!
        List<Database.SaveResult> results = Database.insert(duplicateCons, false);
        Integer numFailed = 0;
        for(Database.SaveResult sr : results){
            if(!sr.isSuccess()){
                numFailed += 1;
            }
        }
        System.assertEquals(100, numFailed);
    }
}