/**
 * Created by mshkrepa on 10/12/2022.
 */

public with sharing class GrossValueCalculatorMethods {

    @AuraEnabled (Cacheable = true)
    public static String  getCountryCode(Id id){
        User user=[SELECT Address FROM User WHERE User.Id=:id];
        return user.Address.getCountry();
    }

}