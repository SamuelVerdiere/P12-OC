@RestResource(urlMapping='/Contacts/*')
public with sharing class ContactManager {
    @HttpPost
    public static Id createContact(String enterName, String enterMail, String enterPhone) {
            //get email from existing contact in SF
        List<Contact> existingContact = [SELECT Id, Name FROM Contact WHERE Email=:enterMail];
            //if contact exists in SF, send Id to AXG
        if (existingContact.size() >0) {
            return existingContact[0].Id;
        }
        //else if contact doesn't exist in SF, create it and return its id
        else {
            Contact newContact = new Contact(Name=enterName, Email=enterMail, Phone=enterPhone);
            insert newContact;
            return newContact.Id;
        }
    }

    @HttpPatch
    public static updateContactInSF() {
            //get the contact that is to be modified
        RestRequest request = RestContext.request;
        String idContact = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Contact myContact = [SELECT Id FROM Contact WHERE Id =: idContact];
            //Deserialise the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.DeserialiseUntyped(request.requestbody.tostring());
        //iterate through each parameter field and value
        for(String fieldName : params.keySet()){
            //set the field and value on the Contact SObject
            myContact.put(fieldName, params.get(fieldName));
            if(fieldName == 'Email') {

            } 
            if(fieldName == 'Name') {

            }
            if(fieldName == 'Phone') {

            }
        }
        update myContact;
        return myContact.Id;
    }

    @HttpDelete
    public static deactivateContactInSF() {
        //get contact the user wants to delete
        RestRequest request = RestContext.request;
        String idContact = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Contact myContact = [SELECT Id FROM Contact WHERE Id = :idContact];
        //only deactivate contact
        myContact.status__c = deactivated;
    }     
}
