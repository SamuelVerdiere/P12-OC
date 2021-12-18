@RestResource(urlMapping='/Contracts/*')
global with sharing class ContractManager {
    @HttpPost
    global static Id createContract(Id enterAccount, String enterStatus, Date enterStart, Integer enterTerm) {
        //when creating a contract in AXG, save it in SF, & save SF's id in AXG
        Contract myContract = new Contract(AccountId=enterAccount, Status=enterStatus, StartDate=enterStart, ContractTerm=enterTerm);
        insert myContract;
        return myContract.Id;
    }
    @HttpPatch
    global static Id updateContract() {
            //get the contract that is to be modifier
        RestRequest request = RestContext.request;
        String idContract = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Contract thisContract = [SELECT Id, Status, StartDate, ContractTerm FROM Contract WHERE Id =: idContract];
            //Deserialise the JSON string in to name-value pairs
            String timedate = String.valueOfGmt(thisContract.StartDate);
            Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestBody.toString());
            //iterate through each parameter field and value
            for(String fieldName : params.keySet()){
                //set the field and value on the Contract SObject
            thisContract.put(fieldName, params.get(fieldName));
            if(fieldName == 'Status') {
                String thatField = (String)thisContract.get('Status');
                thatField = (String)params.get(fieldName);
            }
            if(fieldName == 'StartDate') {
                String thisField = (String)thisContract.get(timedate);
                thisField = (String)params.get(fieldName);
            }
            if(fieldName == 'ContractTerm') {
                String theseField = (String)thisContract.get('ContractTerm');
                theseField = (String)params.get(fieldName);
            }
        }
        update thisContract;
        return thisContract.Id;
    }
}
