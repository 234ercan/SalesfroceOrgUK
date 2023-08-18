public with sharing class ContactUserController {

    public class UserWrapper {
        @AuraEnabled public String username { get; set; }
        @AuraEnabled public String firstName { get; set; }
        @AuraEnabled public String lastName { get; set; }
        @AuraEnabled public String email { get; set; }
    }

    @AuraEnabled(cacheable=true)
    public static UserWrapper getUserInfoByEmail(String contactId) {
        Contact contact = [SELECT Id, Email FROM Contact WHERE Id = :contactId AND Email != null LIMIT 1];
        
        if (contact != null) {
            User user = [SELECT Id, Username, FirstName, LastName, Email FROM User WHERE Email = :contact.Email LIMIT 1];
            
            if (user != null) {
                UserWrapper wrapper = new UserWrapper();
                wrapper.username = user.Username;
                wrapper.firstName = user.FirstName;
                wrapper.lastName = user.LastName;
                wrapper.email = user.Email;
                return wrapper;
            }
        }
        
        return null; // User not found or contact doesn't have an email
    }
}
