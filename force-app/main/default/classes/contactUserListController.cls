public class contactUserListController {
    public class userWrapper {
        @AuraEnabled public string userId { get ; set; }
        @AuraEnabled public string userName { get ; set; }
        @AuraEnabled public string firstName { get ; set; }
        @AuraEnabled public string lastName { get ; set; }
        @AuraEnabled public string email { get ; set; }
    }
    @AuraEnabled (cacheable=true)
    public static List<userWrapper> getUserInfoByEmail(String contactId){
        Contact contact=[SELECT Id, email FROM Contact WHERE Id=:contactId LIMIT 1];
        if(contact!=null){
          List<User> userList = [SELECT Id, Name, FirstName, LastName, Email FROM User WHERE email=:contact.Email];
          
            if(userList.size()>0){
                List<userWrapper> userWrapperList = new List<userWrapper>(); 
                for(User user:userList){
                userWrapper wrapper = new userWrapper();
                	wrapper.userId = user.Id;
                    wrapper.userName = user.Name;
                    wrapper.firstName = user.FirstName;
                    wrapper.lastName = user.LastName;
                    wrapper.email = user.Email;
                    userWrapperList.add(wrapper);
                    }
                return userWrapperList;
            }
        }      
        return null;
    }
}