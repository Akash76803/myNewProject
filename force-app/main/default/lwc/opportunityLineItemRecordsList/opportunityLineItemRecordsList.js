import { LightningElement, api, wire } from 'lwc';
import findOliByOpportunityId from '@salesforce/apex/OliCntroller.findOliByOpportunityId';
export default class OpportunityLineItemRecordsList extends LightningElement {
  columns =  [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Product', fieldName: 'Product2Id'},
        { label: 'Quantity', fieldName: 'Quantity' }    
    ];
    @api opportunityid;
    @wire(findOliByOpportunityId,{opportunityId:'$opportunityId'}) opportunitylineitem;   
}