import { LightningElement, wire } from 'lwc';
import getAccount from '@salesforce/apex/Account_Controller.getAccount'
export default class Account_Controller extends LightningElement {
    @wire(getAccount) accounts;
    
}