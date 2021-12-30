@isTest
public with sharing class ContractManagerTest {
    @TestSetup
    static void createAcc() {
        DataFactoryHelper.createAccount();
    }

    @isTest
    public static void checkContractCreation() {
    // Call the method to test
    Date d = Date.today();
    Account accId = [SELECT Id FROM Account LIMIT 1];
    Id thisContractId = ContractManager.createContract(accId.Id, 'Draft', d, 8);  
    //verify result
    System.assert(thisContractId != null);
    Contract thisContract = [SELECT AccountID, Status, StartDate, ContractTerm FROM Contract WHERE Id=:thisContractId LIMIT 1];
    System.assert(thisContract != null);
    System.assertEquals('Draft', thisContract.Status);
    System.assertEquals(d, thisContract.StartDate);
    System.assertEquals(8, thisContract.ContractTerm);
    }

    @isTest
    public static void checkUpdatedFields() {
       // Date d = Date.today();
        //  Date fd = d.addDays(3);
        Date ContractDate = date.parse('12/12/2021');
         Account accId = [SELECT Id FROM Account LIMIT 1];
         Contract oldContractId = new Contract(AccountId =accId.Id, Status='Draft', StartDate=ContractDate, ContractTerm=8);
         insert oldContractId;
         Contract oldContract = [SELECT AccountID, Status, StartDate, ContractTerm FROM Contract WHERE Id=:oldContractId.Id LIMIT 1];
         RestRequest request = new RestRequest();
         request.requestURI = 'https://mindful-bear-gjovpb-dev-ed.my.salesforce.com/services/apexrest/Contracts/' + oldContract.Id;
         request.httpMethod = 'PATCH';
         request.addHeader('Content-Type', 'application/json');
         request.requestBody = Blob.valueOf('{"Status":"Activated", "StartDate":"12/11/2022", "ContractTerm":"6"}');
         RestContext.request = request;
         Id thisContractId = ContractManager.updateContract();
         System.assert(thisContractId != null);
         Contract newContract =[SELECT AccountID, Status, StartDate, ContractTerm FROM Contract WHERE Id=:thisContractId LIMIT 1];
         System.assertNotEquals(oldContract.Status, newContract.Status);
         System.assertNotEquals(oldContract.StartDate, newContract.StartDate);
    }
}