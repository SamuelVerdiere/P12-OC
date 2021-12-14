@RestResource(urlMapping='/Contracts/*')
public with sharing class ContractManager {
    @HttpPost
    public static Id createContract(String enterAccount, String enterStatus, Date enterStart, Integer enterTerm) {
        //when creating a contract in AXG, save it in SF, & save SF's id in AXG
        Contract myContract = new Contract(AccountId=enterAccount, Status=enterStatus, StartDate=enterStart, ContractTerm=enterTerm);
        insert myContract;
        return myContract.Id;
    }
    @HttpPatch
    public static Id updateContract() {
            //get the contract that is to be modifier
        RestRequest request = RestContext.request;
        String idContract = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Contract thisContract = [SELECT Id FROM Contract WHERE Id =: idContract];
            //Deserialise the JSON string in to name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestBody.tostring());
            //iterate through each parameter field and value
        for(String fieldName : params.keySet()) {
                //set the field and value on the Contract SObject
            thisContract.put(fieldName, params.get(fieldName));
            if(fieldName == 'Status') {
                thisContract.Status = params.get(Status);
            }
            if(fieldName == 'StartDate') {
                thisContract.StartDate = params.get(StartDate);
            }
            if(fieldName == 'ContractTerm') {
                thisContract.ContractTerm = params.get(ContractTerm);
            }
        }
        update thisContract;
        return thisContract.Id;
    }
}
