/**
 * @description       : 
 * @author            : Amit Mathur
 * @group             : 
 * @last modified on  : 18-09-2021
 * @last modified by  : Amit Mathur
**/
public with sharing class WrapperController {

    @AuraEnabled
    public static WrapperClass getAccountAndContactNames(string accountId){
        
            WrapperClass wrapper = new WrapperClass();
            List<Account> accList = [SELECT Id, Name, BillingState, Website, Phone,
            (SELECT Id, FirstName, LastName, Email From Contacts)
            FROM Account WHERE Id =: accountId];

            wrapper.account = accList[0];
            wrapper.listContact = accList[0].Contacts;
            wrapper.headerMessage = accList[0].Contacts.size();

            return wrapper;
        
    }
        public class WrapperClass{
            @AuraEnabled public Account account {get;set;}
            @AuraEnabled public List<Contact> listContact {get;set;}
            @AuraEnabled public Integer headerMessage {get;set;}
 }
}