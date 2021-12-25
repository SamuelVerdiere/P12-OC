@isTest
public with sharing class ContactManagerTest {
    @isTest
    public static void checkContactCreation() {
   // Call the method to test
   ID thisCaseId = ContactManager.createContact('Marshall D', 'Teach', 'pirate@onepiece.com', 'azerty');
    // Verify results
    System.assert(thisCaseId != null);
    Contact thisContact = [SELECT Id, Firstname, LastName, Phone, Password__c FROM Contact WHERE Id=:thisCaseId];
    System.assert(thisContact != null);
    System.assertEquals(thisContact.FirstName, 'Marshall D');
    System.assertEquals(thisContact.LastName, 'Teach');
    System.assertEquals(thisContact.password__c, 'azerty');
    }

@isTest
    public static void checkifContactAlreadyExists() {
   // Call the method to test
    Id myContact = DataFactoryHelper.createTestRecord();
    Contact myContactId = [SELECT Id, Email FROM Contact WHERE Id=:myContact LIMIT 1];
    ID thisContactId = ContactManager.createContact('Marshall D', 'Teach','pirate@onepiece.com', 'azerto');
    // Verify results
    System.assert(thisContactId != null);
    Contact thisContact = [SELECT Id, Firstname, LastName, Phone, Email, Password__c FROM Contact WHERE Id=:thisContactId];
    System.assert(thisContact != null);
    System.assert(myContact != null);
    System.assertEquals(myContactId.Email, thisContact.Email);
    System.assertEquals(myContactId.Id, thisContact.Id);
    }

@isTest
    public static void checkIfFieldsAreUpdated() {
        Id recordId = DataFactoryHelper.createTestRecord();
        Contact oldContact = [SELECT Id, FirstName, LastName, Email, Phone, Password__c FROM Contact WHERE Id=:recordId LIMIT 1];
        RestRequest request = new RestRequest();
        request.requestURI = 'https://mindful-bear-gjovpb-dev-ed.my.salesforce.com/services/apexrest/Contacts/' + recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"FirstName":"Traffalgar D", "LastName":"Waterlaw", "Email":"traffy@legacyd.com", "Phone":"555-5142", "Password__c":"azerto"}');
        RestContext.request = request;
        Id thisContactId = ContactManager.updateContactInSF();
        System.assert(thisContactId != null);
        Contact newContact = [SELECT Id, FirstName, LastName, Email, Phone, Password__c FROM Contact where Id=:thisContactId LIMIT 1];
        System.assert(newContact != null);
        System.assertEquals(newContact.FirstName, 'Traffalgar D');
        System.assertEquals(oldContact.FirstName, 'Marshall D');
        System.assertNotEquals(oldContact.FirstName, newcontact.FirstName);
        System.assertNotEquals(oldContact.LastName, newcontact.LastName);
        System.assertNotEquals(oldContact.Email, newcontact.Email);
        System.assertNotEquals(oldContact.Phone, newcontact.Phone);
        System.assertEquals(oldContact.Id, newcontact.Id);
        System.assertNotEquals(oldContact.password__c, newContact.password__c); }

    @isTest
    public static void testDeletecontact() {
        Id recordId = DataFactoryHelper.createTestRecord();
        Contact oldContact = [SELECT Id, Status__c FROM Contact WHERE Id=:recordId LIMIT 1];
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri ='https://yourInstance.my.salesforce.com/services/apexrest/Cases/' + recordId;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        // Call the method to test
        Id deacContact = ContactManager.deactivateContactInSF();
        //ensure the contact isn't deleted; but its status set on "deactivated"
        Contact contactTest = [SELECT Id, Status__c FROM Contact WHERE Id=:deacContact LIMIT 1];
        System.assertNotEquals(oldContact.Status__c, contactTest.Status__c);
    }
}