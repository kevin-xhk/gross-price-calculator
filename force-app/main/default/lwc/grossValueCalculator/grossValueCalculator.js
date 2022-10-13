/**
 * Created by mshkrepa on 10/12/2022.
 */

import {LightningElement, track, wire} from 'lwc';
import getCountryCode from '@salesforce/apex/GrossValueCalculatorMethods.getCountryCode';
import USER_ID from '@salesforce/user/Id';

export default class GrossValueCalculator extends LightningElement {
    resultValue;

    @wire(getCountryCode, {id : USER_ID})
    countryCode;

    handleValueOnChange(event) {
        this.netValue = parseInt(event.target.value);
    }

    handleValueChange() {
        this.resultValue = this.countryCode.data;
    }

}