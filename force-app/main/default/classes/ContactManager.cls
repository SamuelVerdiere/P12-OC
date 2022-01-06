@RestResource(urlMapping='/Contacts/*')
global with sharing class ContactManager {
    @HttpPost
    global static Id createContact(String enterFirstName, String enterLastName, String enterMail, String enterPass) {
            //get email from existing contact in SF
        List<Contact> existingContact = [SELECT Id, FirstName, LastName FROM Contact WHERE Email=:enterMail];
            //if contact exists in SF, return Id
        if (existingContact.size() >0) {
            return existingContact[0].Id;
        }
        //else if contact doesn't exist in SF, create it and return its id
        else {
            Contact newContact = new Contact(FirstName=enterFirstName, LastName=enterLastName, Email=enterMail, password__c=enterPass);
            insert newContact;
            return newContact.Id;
        }}

    @HttpPatch
    global static Id updateContactInSF() {
            //get the contact that is to be modified
        RestRequest request = RestContext.request;
        String idContact = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Contact myContact = [SELECT Id, Email, FirstName, LastName, Phone, password__c FROM Contact WHERE Id =: idContact];
            //Deserialise the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestBody.toString());   
        //get the object from the web service and the new value to change in SF & iterate through each parameter field and value
        for(String fieldName : params.keySet()){
            //set the field and value on the Contact SObject; get (fieldname) has the new value
            myContact.put(fieldName, params.get(fieldName));
            if(fieldName == 'Email') {
               String thatField = (String)myContact.get('Email');
               thatField = (String)params.get(fieldName); } 
            if(fieldName == 'FirstName') {
                String thisField = (String)myContact.get('FirstName');
                thisField = (String)params.get(fieldName);}
            if(fieldName == 'LastName') {
                String thusField = (String)myContact.get('LastName');
                thusField = (String)params.get(fieldName);}
            if(fieldName == 'Phone') {
                String thoseField = (String)myContact.get('Phone');
                thoseField= (String)params.get(fieldName);}
            if(fieldName == 'password__c') {
                String thoseField = (String)myContact.get('password__c');
                thoseField= (String)params.get(fieldName);}}
        update myContact;
        return myContact.Id;
    }

    @HttpDelete
    global static Id deactivateContactInSF() {
        //get contact the user wants to delete
        RestRequest request = RestContext.request;
        String idContact = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Contact myContact = [SELECT Id, Status__c FROM Contact WHERE Id = :idContact];
        //only deactivate contact
        myContact.status__c = 'Deactivated';
        update myContact;
        return myContact.Id;
    }     
}
