import { LightningElement, track, wire, api } from 'lwc';
import getInitialData from '@salesforce/apex/ContactMultiSelectLookupController.getInitialData';
import savecontactData from '@salesforce/apex/ContactMultiSelectLookupController.savecontactData';
import getPrefferedPhonePicklistValues from '@salesforce/apex/ContactMultiSelectLookupController.getPrefferedPhonePicklistValues';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ContactCreateScreenComponent extends LightningElement {


//*****************************DECLARING vARIABLE************************************* */
@track contact ={};// object of contact
@track options = [];//this contain multiselect picklist option
@track selected = []; //Selected values
@track selectedAll = []; //Selected values array with label and value
@track remainingAvailable = []; // 
@track picklistValues;// it contain picklist value.
@track isLoading = false;// spin rendering
@track validphone = false; 
@track resetpage = false;
 
 //*****************************************************LOAD DATA MULTIPICKLIST WHEN RUN*********************************************************************** */
 @wire(getInitialData)
    wiredData(result) {
        console.log('getInitialData', result);
        if (result.data) {
            this.data = result.data.languageOptions;
            this.options = this.data;
            this.picklistValues = result.data.phoneOptions;
            console.log('SelectLang : ', this.SelectLang);

        }
    }
    handleChange(event){
        //input value putting inside contact{}
         this.contact[event.target.name] = event.target.value;
         console.log('Name OUTPUT ::: ', JSON.stringify(this.contact));

         const name = event.target.name;

        const value = event.target.value;

        this.contact[name] = value;

        if (event.target.name == 'Phone') {

            this.phone = event.target.value;

        }
         if (event.target.name == 'Select_Language__c') {

            this.Select_Language__c = event.target.value;

        }
        if (event.target.name == 'Preferred_Phone__c') {

            this.Preferred_Phone__c = event.target.value;

        }

    }

//******************************************* Handle  MULTISELECT PICKLIST***************************************************************************** */
     handleChangeMulti(event) {
        //Selected values putting to Select_Language__c
        const selectedValues = event.detail.value;
        this.contact['Select_Language__c'] = selectedValues ;
        console.log('OUTPUT : ', selectedValues);


        this.selectedAll = [];
        console.log('selected : ', this.selectedValues);

        //Maintain selected values array with label and value
        this.data.forEach((element) => {
            this.selected.forEach((selectedValue) => {
                if (element.value === selectedValue && this.selectedAll.filter(e => e.value === selectedValue).length === 0) {
                    this.selectedAll.push(element);
                }
            });
        });

        //Maintain non-selected values array
        this.remainingAvailable = [];
        this.data.forEach((element) => {
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

    //************************************Getting Picklist values******************************************** */


    //  @wire(getPrefferedPhonePicklistValues)
    // wiredPicklistValues({ data, error }) {
    //     //this.slectedValue = event.detail.value;
    //     if (data) {
    //         this.picklistValues = data.map((value) => ({
    //             label: value,
    //             value: value
    //         }));
    //     } else if (error) {
    //         console.error('Error retrieving picklist values:', error);
    //     }
    // }

    handleIndustryChange(event) {

        const selectedValue = event.detail.value;
        this.contact['Preferred_Phone__c'] = selectedValue;
        console.log('OUTPUT : ', selectedValue);
        // Handle the selected value change here

    }
    //********************************************** CHECKBOX INPUT***********************************************************
    handleCheckboxChange(event){
         console.log('OUTPUT : ', JSON.stringify(event.detail));
        this.contact['Copy_Address__c'] = event.detail.checked;
    }
    //*******************************************CUSTOM LOOKUP*********************************************************************** */

         lookupRecord(event) {
        console.log('OUTPUT : ', JSON.stringify(event.detail));
        this.contact['AccountId'] = event.detail.selectedRecord.Id;
    }


    //****************************************ONCLICK SAVE BUTTON************************************************************** */
    handleClick() {
        
       /*
       savecontactData({ contactData: this.contact })
        .then(result=>{
         console.log('OUTPUT result : ', result);
        })

       */ 
    
    //********************VALIDATION BEFOREC SAVE THE RECORD********************************* */
     if (this.phone && /^[6789]\d{9}$/.test(this.phone) == false) {
            this.validphone = false;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Alert!',
                    message: 'Please fill valid Number!!',
                    variant: 'error'
                })
            );
        } else {
            this.validphone = true;
        }
        if (this.phone && this.validphone == true)  {
            this.isLoading = true;
            savecontactData({
                contactData: this.contact
            }).then(result => {
                console.log('result : ', result);
                this.isLoading = false;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Records Inserted Successfully!!',
                        variant: 'success'
                    })
                );

               
            }).catch(error => {
                this.isLoading = false;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'An Error Occured!!',
                        variant: 'error'
                    })
                );
            });
        } 
        else {
            this.isLoading = false;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Please fill Last Name!!',
                    variant: 'error'
                })
            );
        }
    } 

    //**************************RESET PAGE******************************************************************************************* */
       
     
}