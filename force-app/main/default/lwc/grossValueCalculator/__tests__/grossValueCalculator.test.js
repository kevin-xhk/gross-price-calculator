/* eslint-disable @lwc/lwc/no-document-query */
import 'core-js';
import { createElement } from 'lwc';
import GrossValueCalculator from 'c/grossValueCalculator';
import getApiResponse from '@salesforce/apex/ApiController.getApiResponse';
import getCountryCode from '@salesforce/apex/GrossValueCalculatorMethods.getCountryCode';

const API_RESPONSE_ALBANIA = require('./data/apiResponseAlbania.json');
const GET_COUNTRY_CODE_RESPONSE_AL = require('./data/getCountryCodeResponseAlbania.json');

jest.mock('@salesforce/apex/ApiController.getCountryCode',
    () => ({
        default:jest.fn()
    }),
    {virtual: true}
)

jest.mock('@salesforce/apex/ApiController.getApiResponse',
    () => ({
        default:jest.fn()
    }),
    {virtual: true}
)


describe('c-gross-value-calculator suite', () => {

    beforeEach(() => {
        const element = createElement('c-gross-value-calculator', {
            is: GrossValueCalculator
        });
        document.body.appendChild(element);
    })

    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('outputs the proper gross rate for Albanian users', () => {
        // given
        getCountryCode.mockResolvedValue(GET_COUNTRY_CODE_RESPONSE_AL)
        getApiResponse.mockResolvedValue(API_RESPONSE_ALBANIA)
        const element = document.querySelector('c-gross-value-calculator')
        const inputElement = element.shadowRoot.querySelector('lightning-input')
        const buttonElement = element.shadowRoot.querySelector('lightning-button')
        
        // when
        inputElement.value = 100
        inputElement.dispatchEvent(new CustomEvent('change'))
        buttonElement.click();
        
        //then
        return new Promise(setImmediate).then(() => {
            const resultElement = element.shadowRoot.querySelector('span')
            expect(resultElement.textContent).toBe(120)
        })
    });
});