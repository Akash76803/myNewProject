import { LightningElement, wire, track, api } from 'lwc';
import displayContact from '@salesforce/apex/LwcControllerOpportunity.displayContact';
import displayOpportunityAccountContactntData from '@salesforce/apex/LwcControllerOpportunity.displayOpportunityAccountContactntData';
export default class OpportunityContactAccount extends LightningElement {
@track draftValues =[];
@api recordId;
@track Conlist = [];

@track columns = [
    { label: 'First Name', fieldName: 'Name', editable: true },
    { label: 'Account', fieldName: 'accountname', editable: true },
    { label: 'Phone', fieldName: 'phone', type: 'phone', editable: true },
   
];


//passing data to conlist varible and this variable is used in html to show data on datatable.
@wire(displayOpportunityAccountContactntData, { recordId: '$recordId' })
wiredata(result){
    console.log('result',result);
    if(result.data){
        this.Conlist = result.data.Contact;
        console.log('this.ContactList',this.Conlist);
    }
}

//This function basically works when we click on save button.
handlesave(event){
const temp = event.target.draftValues;
console.log('OUTPUT1 : ', event.target.draftValues);
try{
displayContact({displayContact: temp})
.then((result) => {
    this.saveDraftValues = undefined;
    console.log('OUTPUT Result : ', result);
}).catch((err) => {
    console.log('OUTPUT 3 : ',err);
});

}catch(err){
console.log('OUTPUT2 : ',err);
}


console.log("dada--->",event.detail.draftValues)

}

}