@isTest
public with sharing class AccountManagerTest {

    @isTest
    public static void checkIfIdIsReturned() {
        //get the id to compare later
        ID thisAccountId = AccountManager.createAccount('TestingAccount');
        // Verify results
        System.assert(thisAccountId != null);
        Account thisAccount = [SELECT Id, Name FROM Account WHERE Id=:thisAccountId];
        System.assert(thisAccount != null);
        System.assertEquals(thisAccount.Name, 'TestingAccount');
    }
}