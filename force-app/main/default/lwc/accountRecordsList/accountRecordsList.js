import { LightningElement,wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
export default class AccountRecordsList extends LightningElement {
    @wire(getAccounts) accounts;
   @track accountidfrmparent;
    handleClick(event){
        event.preventDefault();     
        this.accountidfrmparent = event.target.dataset.accountid;  
        console.log('OUTPUT : ',this.accountidfrmparent);     
    }
}