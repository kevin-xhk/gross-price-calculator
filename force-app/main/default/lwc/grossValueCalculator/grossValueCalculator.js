/**
 * Created by mshkrepa on 10/12/2022.
 */

import {LightningElement} from 'lwc';
import getCountryCode from '@salesforce/apex/GrossValueCalculatorMethods.getCountryCode';
import getApiResponse from '@salesforce/apex/ApiController.getApiResponse';
import USER_ID from '@salesforce/user/Id';

export default class GrossValueCalculator extends LightningElement {

    resultValue;
    apiRate;
    countryCode;

    handleValueOnChange(event) {
        this.netValue = parseFloat(event.target.value);
    }

    //Get Country Code and then VAT Rate from API on component load
    connectedCallback() {
        getCountryCode({ userId: USER_ID })
            .then(result => {
                this.countryCode = result;
            })
            .then(() => {
                this.getVatRateFromApi();
            })
            .catch(error => {
                console.log(error);
            });
    }

    getVatRateFromApi() {
        getApiResponse({ countryCode: this.countryCode })
            .then((response) => {
                return JSON.parse(response);
            })
            .then((jsonResponse) => {
                let Standard_Rate = {
                    rate: '',
                };
                let exchangeData = jsonResponse['standard_rate'];
                Standard_Rate.rate = exchangeData['rate'];
                this.apiRate = Standard_Rate.rate;
            })
            .catch(error => {
                console.log('callout error ===> ' + error);
            })

    }

    handleButtonClick() {
        this.resultValue = this.netValue+(this.netValue*this.apiRate);
    }

}