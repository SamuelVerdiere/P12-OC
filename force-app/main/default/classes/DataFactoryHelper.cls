@isTest
public with sharing class DataFactoryHelper {
        public static Id createTestRecord() {
            // Create test record
            Contact contactTest = new Contact(FirstName='Marshall D', LastName='Teach',Email='pirate@onepiece.com',Phone='666-5142');
            insert contactTest;
            return contactTest.Id;
        }
        public static Id createAccount() {
            Account testaccount = new Account(Name='Testing');
            insert testaccount;
            return testaccount.Id;
        }
    }