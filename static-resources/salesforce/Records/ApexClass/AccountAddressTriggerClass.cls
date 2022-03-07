public class AccountAddressTriggerClass {
    
    public static void updateBillingAddress(List<Account> accounts){
        
        for(Account a : accounts){
            if(a.Match_Billing_Address__c == true && a.BillingPostalCode != ''){
                a.ShippingPostalCode = a.BillingPostalCode;
            }
        }
    }

}