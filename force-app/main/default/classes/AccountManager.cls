@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {
    
    @HttpPost
    global static Id createAccount(String enterName) {
        Account myAccount = new Account(Name=enterName);
        insert myAccount;
        return myAccount.Id;
    }

    @HttpPatch
    global static Id updateAccount() {
    RestRequest request = RestContext.request;
    String id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
    Account thisAccount = [SELECT Id FROM Account WHERE Id = :id];
    Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestBody.toString());
    for(String fieldName : params.keySet()){
        if(fieldName == 'Name') {
            String thatField = (String)params.get('Name');
            thatField =(String)params.get(fieldname);
            thisAccount.put(fieldname, thatField);
        }
    }
    update thisAccount;
    return thisAccount.Id;
}
}