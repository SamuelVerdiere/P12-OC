@isTest
public with sharing class ContactManagerTest {
    @isTest
    public static void checkContactCreation() {
   // Call the method to test
   ID thisCaseId = ContactManager.createContact('Marshall D', 'Teach', 'pirate@onepiece.com', '666-5142');
    // Verify results
    System.assert(thisCaseId != null);
    Contact thisContact = [SELECT Id, Firstname, LastName, Phone, Email FROM Contact WHERE Id=:thisCaseId];
    System.assert(thisContact != null);
    System.assertEquals(thisContact.FirstName, 'Marshall D');
    System.assertEquals(thisContact.LastName, 'Teach');
    System.assertEquals(thisContact.Phone, '666-5142');
    }

@isTest
    public static void checkifContactAlreadyExists() {
   // Call the method to test
   Contact myContact = new Contact(FirstName='Marshall D', LastName='Teach', Email='pirate@onepiece.com', Phone='666-5142');
   insert myContact;
   Contact myContactId = [SELECT Id, Email FROM Contact LIMIT 1];
   ID thisContactId = ContactManager.createContact('Marshall D', 'Teach','pirate@onepiece.com', '666-5142');
    // Verify results
    System.assert(thisContactId != null);
    Contact thisContact = [SELECT Id, Firstname, LastName, Phone, Email FROM Contact WHERE Id=:thisContactId];
    System.assert(thisContact != null);
    System.assert(myContact != null);
    System.assertEquals(myContact.Email, thisContact.Email);
    System.assertEquals(myContact.Id, thisContact.Id);
    }

@isTest
    public static void checkIfFieldsAreUpdated() {
        Contact myContact = new Contact(FirstName='Marshall D', LastName='Teach', Email='pirate@onepiece.com', Phone='666-5142');
        insert myContact;
        Contact myContacte = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact LIMIT 1];
        Contact thisContact = ContactManager.updateContactInSF('emperors@onepiece.com', 'MarshallD', 'Teech', '666-5142');
        Contact newcontact = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact LIMIT 1];
        System.assert(myContacte.Id != null);
        System.assertNotEquals(myContacte.FirstName, newcontact.FirstName);
        System.assertNotEquals(myContacte.LastName, newcontact.LastName);
        System.assertNotEquals(myContacte.Email, newcontact.Email);
        System.assertNotEquals(myContacte.Phone, newcontact.Phone);
        System.assertEquals(myContacte.Id, newcontact.Id);
    }
}

/*
    @isTest static void testUpdateCaseFields() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"status": "Working"}');
        RestContext.request = request;
        // Update status of existing record to Working
        ID thisCaseId = CaseManager.updateCaseFields();
        // Verify record was updated
        System.assert(thisCaseId != null);
        Case thisCase = [SELECT Id,Status FROM Case WHERE Id=:thisCaseId];
        System.assert(thisCase != null);
        System.assertEquals(thisCase.Status, 'Working');
    }  

*/



/*
    @isTest static void testUpsertCase() {
        // 1. Insert new record
        ID case1Id = CaseManager.upsertCase(
                'Ferocious chipmunk', 'New', 'Phone', 'Low', null);
        // Verify new record was created
        System.assert(Case1Id != null);
        Case case1 = [SELECT Id,Subject FROM Case WHERE Id=:case1Id];
        System.assert(case1 != null);
        System.assertEquals(case1.Subject, 'Ferocious chipmunk');
        // 2. Update status of existing record to Working
        ID case2Id = CaseManager.upsertCase(
                'Ferocious chipmunk', 'Working', 'Phone', 'Low', case1Id);
        // Verify record was updated
        System.assertEquals(case1Id, case2Id);
        Case case2 = [SELECT Id,Status FROM Case WHERE Id=:case2Id];
        System.assert(case2 != null);
        System.assertEquals(case2.Status, 'Working');
    }    
    @isTest static void testUpdateCaseFields() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"status": "Working"}');
        RestContext.request = request;
        // Update status of existing record to Working
        ID thisCaseId = CaseManager.updateCaseFields();
        // Verify record was updated
        System.assert(thisCaseId != null);
        Case thisCase = [SELECT Id,Status FROM Case WHERE Id=:thisCaseId];
        System.assert(thisCase != null);
        System.assertEquals(thisCase.Status, 'Working');
    }  

*/