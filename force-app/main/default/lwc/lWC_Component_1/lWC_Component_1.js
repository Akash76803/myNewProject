import { LightningElement, api, wire } from 'lwc';
import{getRecord, getFieldValue} from 'lightning/uiRecordApi';
//import NAME_FIELD from '@salesforce/schema/Account.Name';
//import PHONE_FIELD from '@salesforce/schema/Account.Phone';
export default class LWC_Component_1 extends LightningElement {
    

		@wire(getRecord, {recordId: '$recordId', fields: ['Account.Name', 'Account.Phone'] })
    record;

    get name(){
     return this.record.data ? getFieldValue (this.record.data.Account.Name) : '';
    }
    get phone(){
       return this.record.data ? getFieldValue (this.record.data.Account.Phone) : '';
    }
  	message = 'private property';
		@api recordId; 

  	name = 'Sagar';
    company ='AgroService';
    designation ='SR.Executive';
    
}