// CHILD COMPONENT JS
import { LightningElement, track, wire, api } from 'lwc';
import retrieveAccountRecords from '@salesforce/apex/ContactMultiSelectLookupController.retrieveAccountRecords';
import retrieveContactRecords from '@salesforce/apex/ContactMultiSelectLookupController.retrieveContactRecords';
 
export default class AccountRelatedContactTable extends LightningElement {
    @track l_All_Types;
    @track TypeOptions;

    @track ConTypes;
    @track contactOption;
    @api recordId;
    @track errorMsg;    
    @track selectedAcc;
    @track selectedCon;

    @wire(retrieveAccountRecords, {})
    WiredObjects_Type({ error, data }) {
 
        if (data) {
            try {
                this.l_All_Types = data; 
                let options = [];
                 
                for (var key in data) {
                    // Here key will have index of list of records starting from 0,1,2,....
                    options.push({ label: data[key].Name, value: data[key].Id  });
 
                    // Here Name and Id are fields from sObject list.
                }
                this.TypeOptions = options;
                 
            } catch (error) {
                console.error('check error here', error);
            }
        } else if (error) {
            console.error('check error here', error);
        }
 
    }

    //**************************************************CONTACT ***************************/
   
    @wire(retrieveContactRecords, { accId: '$recordId' })
    wiredData({ error, data }) {
        if(data){
            console.log('OUTPUT : ', data);
                 try {
                this.ConTypes = data; 
                let options = [];
                 
                for (var key in data) {
                    // Here key will have index of list of records starting from 0,1,2,....
                    options.push({ label: data[key].Name, value: data[key].Id  });
 
                    // Here Name and Id are fields from sObject list.
                }
                this.contactOption = options;
                 
            } catch (error) {
                console.error('check error here', error);
            }
        } else if (error) {
            console.error('check error here', error);
        }
     
    }
 
    handleTypeChange(event){
       this.selectedAcc = event.target.value; 
       console.log('OUTPUT this.selectedAcc : ', this.selectedAcc);
        // Do Something.
    }

    handleAccountChange(event){
       this.selectedCon = event.target.value; 
        console.log('OUTPUT selectedCon : ', this.selectedCon);
        // Do Something.
    }

   
   
}