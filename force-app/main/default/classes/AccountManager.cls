@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {
    
    @HttpPost
    global static Id createAccount(String enterName) {
        Account myAccount = new Account(Name=enterName);
       // Account result = [SELECT Id FROM Account WHERE Name = :enterName];
        insert myAccount;
        return myAccount.Id;
    }
}