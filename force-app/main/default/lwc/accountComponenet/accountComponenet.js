import { LightningElement, wire, track, api } from 'lwc';
import displayContactntData from '@salesforce/apex/LWCController1.displayContactntData';
import displayOpportunityAccountContactntData from '@salesforce/apex/LWCController1.displayOpportunityAccountContactntData';

export default class AccountComponenet extends LightningElement {
  

  @track columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Fax', fieldName: 'Fax' },
    { label: 'Account', fieldName: 'Account' },
   
];
@track ContactList = [];
@track opAccConlist = [];
@api recordId;
@api dummyId;
@wire(displayContactntData)
wiredata(result){
    console.log('result',result);
    if(result.data){
        this.ContactList = result.data.contact;
        console.log('this.ContactList',this.ContactList);
    }
}
   
   @wire(displayOpportunityAccountContactntData, { recordId: '$recordId' })
   wiredDataaa({ error, data }) {
     if (data) {
         console.log('Data', data);
         this.opAccConlist = data.Contact;
         
         if(this.recordId!= undefined){
             this.dummyId = this.recordId;
         }
        
       console.log('Data', this.opAccConlist);
     } else if (error) {
        console.error('Error:', error);
     }
   }
      handleClick(){
        if(this.recordId != undefined){
          this.recordId =undefined;
        }else{
          this.recordId = this.dummyId;
        }
      }

      connectedCallback() {
       displayOpportunityAccountContactntData({recordId:this.recordId})
       .then((result) => {
         console.log('OUTPUT: ', result);
         this.opAccConlist = result.Contact;
       }).catch((err) => {
         
       });
      }    
}