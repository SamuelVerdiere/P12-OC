@isTest
public with sharing class AccountManagerTest {

    @isTest
    public static void checkIfIdIsReturned() {
        ID thisAccountId = AccountManager.createAccount('TestingAccount');
        System.assert(thisAccountId != null);
        Account thisAccount = [SELECT Id, Name FROM Account WHERE Id=:thisAccountId];
        System.assert(thisAccount != null);
        System.assertEquals(thisAccount.Name, 'TestingAccount');
    }

    @isTest
    public static void checkifFieldsareUpdated() {
        Account myaccount = new Account(Name='Testing Account');
        insert myaccount;
        Account thisAccount = [SELECT Id, Name FROM Account WHERE Id=:myaccount.Id LIMIT 1];
        RestRequest request = new RestRequest();
        request.requestURI = 'https://mindful-bear-gjovpb-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + thisAccount.Id;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Name":"Testing Account Updated"}');
        RestContext.request = request;
        Id thisAccountId = AccountManager.updateAccount();
        System.assert(thisAccountId != null);
        Account newAccount = [SELECT NAme FROM Account WHERE Id=:thisAccountId LIMIT 1];
        System.assertNotEquals(thisAccount.Name, newAccount.Name);
    }
}