import { LightningElement, wire, track } from 'lwc';
import getOpportunity from '@salesforce/apex/OpportunityController.getOpportunity';
export default class OpportunityRecordsList extends LightningElement {

@wire(getOpportunity) opportunity;

   @track opportunityidfrmparent;
    handleClick(event){
        event.preventDefault();     
        this.opportunityidfrmparent = event.target.dataset.opportunityid;   
        console.log('OUTPUT : ',this.opportunityidfrmparent);    
    }
}