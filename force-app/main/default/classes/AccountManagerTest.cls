@isTest
public with sharing class AccountManagerTest {
    @isTest
    public static void checkIfIdIsReturned() {
        //get the id to compare later
        Id accId = DataFactoryHelper.createAccount();
        Account AccountId = [SELECT Id FROM Account LIMIT 1];
        RestRequest request = new RestRequest();
        request.requestURI = 'https://mindful-bear-gjovpb-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + accId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Id returnedAccountId = AccountManager.getAccount();
        Account myAccount = [SELECT Id FROM Account WHERE Id =:returnedAccountId LIMIT 1];
        System.assert(myAccount != null);
        System.assertEquals(AccountId.Id, myAccount.Id);
    }
}
