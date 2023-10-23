public with sharing class AccountCreation {
@AuraEnabled
    public static string acct(string n){
        Account a = new Account(name=n);
        insert a;
        system.debug(a);
        if(a.Id != null){
            return 'success';
        }else{
            return 'error';
        }
    }
}
