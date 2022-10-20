/**
 * Created by mshkrepa on 10/19/2022.
 */
@IsTest
public with sharing class ApiLayerHttpCalloutMock implements HttpCalloutMock{

    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"success":true,"country_code":"AL","country_name":"Albania","eu":false,"standard_rate":{"rate":0.2,"class":"standard","description":"","types":null},"other_rates":[{"rate":0.06,"class":"reduced","description":"Hotel accommodation and services","types":null,"types_array":[]}]}');
        response.setStatusCode(200);
        return response;
    }
}