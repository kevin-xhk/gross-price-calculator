/**
 * Created by mshkrepa on 10/17/2022.
 */

public with sharing class ApiController {

    @AuraEnabled (Cacheable = true)
    public static String getApiResponse(String countryCode){
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('callout:VAT_API_Layer/tax_data/tax_rates?country='+countryCode);
        req.setHeader('apikey', '{!$Credential.Password}');
        req.setHeader('Content-Type', 'application/json');
        HttpResponse res = new Http().send(req);
        System.debug(res.getBody());
        return res.getBody();
    }

}