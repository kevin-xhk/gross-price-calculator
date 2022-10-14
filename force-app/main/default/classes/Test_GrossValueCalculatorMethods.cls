@isTest
public with sharing class Test_GrossValueCalculatorMethods {
    @isTest
    public static void testGetCountryCode() {
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
}