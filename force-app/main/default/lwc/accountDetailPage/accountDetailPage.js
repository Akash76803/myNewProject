import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class AccountDetailPage extends LightningElement {
  @api recordId; // The account Id passed from the parent component
  account;

  @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME_FIELD, ACCOUNT_INDUSTRY_FIELD] })
  wiredAccount({ error, data }) {
    if (data) {
      this.account = {
        Name: getFieldValue(data, ACCOUNT_NAME_FIELD),
        Industry: getFieldValue(data, ACCOUNT_INDUSTRY_FIELD),
      };
    } else if (error) {
      console.error(error);
    }
  }
}