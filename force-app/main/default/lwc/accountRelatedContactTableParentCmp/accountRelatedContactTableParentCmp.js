// PARENT COMPONENT JS
import { LightningElement, track, wire, api } from 'lwc';
import retrieveContactRecords from '@salesforce/apex/ContactMultiSelectLookupController.retrieveContactRecords';
 
export default class AccountRelatedContactTableParentCmp extends LightningElement {
      
    @api recordId;
    @track records =[];
    @track errorMsg;    
    @track Contact =[];
   
       @wire(retrieveContactRecords, {accId:'$recordId'})
    wireConRecord({ error, data }) {
        if (data) {
            this.records = data.map(contact => ({
                label: contact.Name,
                value: contact.Id
            }));
            console.log('OUTPUT list : ',  this.records);
        } else if (error) {
            // Handle error if necessary
        }
    }
    

lookupContactRecord(event) {
        console.log('OUTPUT : ', JSON.stringify(event.detail));
        this.records['Id'] = event.detail.selectedRecord.Id;
    }
 
}