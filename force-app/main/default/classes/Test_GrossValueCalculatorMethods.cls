@isTest
public with sharing class Test_GrossValueCalculatorMethods {

    @isTest
    public static void testGetCountryCodePositive () {

        // GIVEN
        Id systemAdminProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        String expectedUserCountry = 'US';
        User expectedUser = new User(
            Username = 'kxhemailtest3012000@tesxht.com',
            FirstName = 'First',
            LastName = 'Last',
            Alias = 'Alias',
            Email = 'emailtest@test.com',
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'ISO-8859-1',
            ProfileId = systemAdminProfileId,
            LanguageLocaleKey = 'en_US',
            Country = expectedUserCountry
        );

        insert expectedUser;

        // WHEN
        Test.startTest();
        String actualUserCountry = GrossValueCalculatorMethods.getCountryCode(expectedUser.Id);
        Test.stopTest();
        
        // THEN
        System.assertEquals(expectedUserCountry, actualUserCountry, 'Countries do not Match');
    }

    @isTest
    public static void testGetCountryCodeNegative() {

        // GIVEN
        Id systemAdminProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        User expectedUser = new User(
            Username = 'kxhemailtest3012000@tesxht.com',
            FirstName = 'First',
            LastName = 'Last',
            Alias = 'Alias',
            Email = 'emailtest@test.com',
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'ISO-8859-1',
            ProfileId = systemAdminProfileId,
            LanguageLocaleKey = 'en_US'
        );
        insert expectedUser;

        // WHEN
        Test.startTest();
        Boolean flag = false;
        try {
            GrossValueCalculatorMethods.getCountryCode(expectedUser.Id);
        } catch(Exception e) {
            flag = true;
        }
        Test.stopTest();
        
        // THEN
        System.assert(flag, 'Country field is Empty');
    }
}