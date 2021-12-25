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
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestBody.toString());
            //iterate through each parameter field and value
        for(String fieldName : params.keySet()){
                //set the field and value on the Contract SObject
            if(fieldName == 'Status') {
                 String thatField = (String)params.get('Status');
                 thatField = (String)params.get(fieldName);
                 thisContract.put(fieldName, thatField); //on convertit et on ajoute la nouvelle valeur dans l'objet thatfield/thiscontact
             }
            if(fieldName == 'StartDate') {
                //if Date = we gather the string format and convert it to date
                Date thisFieldDate = date.parse((String)params.get('StartDate'));
                thisContract.put(fieldName, thisFieldDate); 
            }
            if(fieldName == 'ContractTerm') {
                Integer theseField = Integer.valueOf((String)params.get('ContractTerm'));
                thisContract.put(fieldName, theseField);
            }}
        update thisContract;
        return thisContract.Id;
    }
}
