import { LightningElement, track, wire, api } from 'lwc';
import { CloseActionScreenEvent } from "lightning/actions";
import saveTaskData from '@salesforce/apex/ContactMultiSelectLookupController.saveTaskData';
import getInitialData from '@salesforce/apex/ContactMultiSelectLookupController.getInitialData';
import savetask from '@salesforce/apex/ContactMultiSelectLookupController.savetask';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

 const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Type', fieldName: 'Type', type: 'text' },
    { label: 'Account Number', fieldName: 'AccountNumber'}
];
export default class TaskLwcComponent extends LightningElement { 
    @track controllerValue;
    @track dependentValue;
    @track accountIds; // The Account Id passed to the child component
    @track selectedAccount;
    @track Task ={};
    @track options = [];
    @track selected = []; //Selected values
    @track selectedAll = []; //Selected values array with label and value
    @track remainingAvailable = [];
    @track picklistValues;
    @track PrioritypicklistValues;
    @track StatuspicklistValues;
    @track selectedRecords = [];
    @track selectedRecordsLength;
    columns = columns;

//*************************Loading subject picklist values****************************/
        @wire(getInitialData)
    wiredPicklistValues({ data, error }) {
        //this.slectedValue = event.detail.value
        if (data) {
            console.log('OUTPUT data : ',data);
            this.PrioritypicklistValues = data.PriorityOptions;
            this.StatuspicklistValues = data.StatusOptions;
            this.picklistValues = data.SubjectOptions;
            this.options = data.languageSelectOptions;
        } else if (error) {
            console.error('Error retrieving picklist values:', error);
        }
    }
     
//************************multi select picklist search************************
    handleChangeMulti(event) {
        //Selected values putting to Select_Language__c
        const value = event.detail.value;
        const name = event.target.name;
        console.log('Name : ', name);
        //  this.Task['Select_Language__c'] = selectedValues ;
        // console.log('OUTPUT : ', selectedValues);

    if(name == 'Select_Language__c'){

            this.Task[name] = value.join(';');

        }else{

            this.Task[name] = value;

        }


        this.selectedAll = [];
        console.log('selected : ', this.selectedValues);

        //Maintain selected values array with label and value
        this.options.forEach((element) => {
            this.selected.forEach((selectedValue) => {
                if (element.value === selectedValue && this.selectedAll.filter(e => e.value === selectedValue).length === 0) {
                    this.selectedAll.push(element);
                }
            });
        });

        //Maintain non-selected values array
        this.remainingAvailable = [];
        this.options.forEach((element) => {
            if (this.selectedAll.filter(e => e.value === element.value).length === 0) {
                this.remainingAvailable.push(element);
            }
        });
    }

    handleAvailableSearch(event) {
        let searchValue = event.detail.value;
        if (searchValue) {
            //Search for data in the Available options
            let newOptions = this.searchData(this.data, searchValue, false);

            //Add selected values in the options
            this.data.forEach((element) => {
                if (this.selected.filter(e => e === element.value).length === 1) {
                    newOptions.push(element);
                }
            });
            this.options = newOptions;
        } else {
            //Reset search result
            this.options = this.data;
        }
    }

    handleSelectedSearch(event) {
        let searchValue = event.detail.value;
        if (searchValue) {
            //Search for data in the Available options
            this.selected = this.searchData(this.selectedAll, searchValue, true);
            let newOptions = [];

            //Maintain selected values array with label and value
            this.data.forEach((element) => {
                if (this.selected.filter(e => e === element.value).length === 1) {
                    newOptions.push(element);
                }
            });
            //Add available values in the options
            this.remainingAvailable.forEach((element) => {
                newOptions.push(element);
            });
            this.options = newOptions;
        } else {
            //Reset the selected values
            let selectedValues = [];
            this.selectedAll.forEach((element) => {
                selectedValues.push(element.value);
            });
            this.selected = selectedValues;
            this.options = this.data;
        }
    }   

    searchData(allData, searchValue, returnValue) {
        let filterData = [];
        allData.forEach((element) => {
            //Search data
            if (element.label.toLowerCase().indexOf(searchValue.toLowerCase()) !== -1) {
                if (returnValue) {
                    filterData.push(element.value);
                } else {
                    filterData.push(element);
                }
            }
        });
        return filterData;
     }

//****************Handle Selected picklist value */
 handleChange(event) {
     this.Task[event.target.name] = event.target.value;
     console.log(' task OUTPUT : ', this.Task);
    }
    /******************************PICKLIST CONTROLLING HANDLECHNAGE*******************************************/ 
   callFromChild(event){
        this.controllerValue = event.detail.controllerValue;
        this.dependentValue = event.detail.dependentValue
        alert(this.controllerValue + '----' + this.dependentValue);
        console.log(JSON.stringify(event.detail));
    }
    
//************************Handlechange event******************************************* */
    handleDateChange(event) {
        const dueDate = event.detail.value;
        this.Task['ActivityDate'] = dueDate;
        console.log('OUTPUT : ', dueDate);
    }  
//********************************************Account LookUp************************* */
        lookupRecord(event) {
        console.log('OUTPUT : ', JSON.stringify(event.detail));
        this.Task['WhatId'] = event.detail.selectedRecord.Id;
        console.log('TaskDetails[WhatId]', this.Task['WhatId']);
        this.accountIds = this.Task['WhatId'] ;
        console.log('accountIds : ', this.accountIds);
        
    }
    // User/AssignTo in task Lookup
     lookupUserRecord(event) {
        console.log('OUTPUT : ', JSON.stringify(event.detail));
        this.Task['OwnerId'] = event.detail.selectedRecord.Id;
    }

     
    //********************************************** Multi-Lookup************************** */
     handleselectedContactRecord(event) {
         console.log('handleselectedContactRecord OUTPUT : ',JSON.stringify( event.detail) );
        this.Task['WhoId'] = event.detail.selRecords
        this.selectedRecordsLength = this.selectedRecords.length;
        
    }
//*********************************ON CANCEL MODAL WILL BE CLOSED**********************
    hideModalBox() {  
        this.dispatchEvent(new CloseActionScreenEvent());
    }
//*********************************ON SAVE MODAL WILL BE CLOSED**********************
    Onsave(){
        saveTaskData({taskData: this.Task}) 
        
        .then((result) => {
            console.log('OUTPUT result : ', result);
            this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Records Inserted Successfully!!',
                        variant: 'success'
                    })
                );
        }).catch((err) => {
            console.log('OUTPUT error : ', err.message);
        });

        savetask({obj: this.Task})
        .then((result) => {
            console.log('OUTPUT result : ', result);
            this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Records Inserted Successfully!!',
                        variant: 'success'
                    })
                );
        }).catch((err) => {
            console.log('OUTPUT error : ', err.message);
        });
        this.dispatchEvent(new CloseActionScreenEvent());
    }
    
}