@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {
    
    @HttpGet
    global static Id getAccount() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id FROM Account WHERE Id = :accountId];
        System.debug('THIS IS THE RESULT ID : ' + result.Id);
        return result.Id;
    }
}