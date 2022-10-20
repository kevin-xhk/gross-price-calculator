/**
 * Created by mshkrepa on 10/19/2022.
 */
@IsTest
public with sharing class ApiControllerTEST {

    @IsTest
    public static void testApiCallout(){
        Test.setMock(HttpCalloutMock.class, new ApiLayerHttpCalloutMock());
        String countryCode='AL';
        Decimal expectedVatRate=0.2;
        String response = ApiController.getApiResponse(countryCode);
        Map<String, Object> mappedResponse = (Map<String, Object>) JSON.deserializeUntyped(response);
        Map<String, Object> mappedStandardRate = (Map<String, Object>) mappedResponse.get('standard_rate');
        Decimal actualVatRate=(Decimal) mappedStandardRate.get('rate');
        System.assertEquals(expectedVatRate,actualVatRate);
    }

}