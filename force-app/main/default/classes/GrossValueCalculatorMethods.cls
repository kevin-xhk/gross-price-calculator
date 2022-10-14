/**
 * Created by mshkrepa on 10/12/2022.
 */

public with sharing class GrossValueCalculatorMethods {

    @AuraEnabled (Cacheable = true)
    public static String  getCountryCode(Id userId){
        User user=[SELECT Address FROM User WHERE User.Id=:userId];
        return user.Address.getCountry();
    }

}