import { LightningElement, track, wire, api } from 'lwc';
import savecontactData from '@salesforce/apex/LwcController3.savecontactData';
import getInitialData from '@salesforce/apex/LwcController3.getInitialData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class LwcComponent3 extends LightningElement {
    @track contact = {};

    @track isLoading = false;

    @track validphone = false;

  

    //******************************************************************* */
    @track SelectLang = [];
      @track selected = []; //Selected values
      
    @track selectedAll = []; //Selected values array with label and value
    @track remainingAvailable = []; //
    handleChange(event) {
        //Selected values
        this.selected = event.detail.value;
        this.selectedAll = [];
        console.log('selected : ', this.selected);
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
    //******************************************************************* */

    //************************************************************************************ */
    @track selectedItemsToDisplay = ''; //to display items in comma-delimited way
    @track values = []; //stores the labels in this array
    @track isItemExists = false; //flag to check if message can be displayed

    //captures the retrieve event propagated from lookup component
    selectItemEventHandler(event) {
        let args = JSON.parse(JSON.stringify(event.detail.arrItems));
        this.displayItem(args);
        console.log('args : ', args);
    }

    //captures the remove event propagated from lookup component
    deleteItemEventHandler(event) {
        let args = JSON.parse(JSON.stringify(event.detail.arrItems));
        this.displayItem(args);
        console.log('Show Delete data : ', args);
    }

    //displays the items in comma-delimited way
    displayItem(args) {
        this.values = []; //initialize first
        args.map(element => {
            this.values.push(element.label);
            console.log('Show data : ', this.values.push(element.label));
        });

        this.isItemExists = (args.length > 0);
        this.selectedItemsToDisplay = this.values.join(', ');
        console.log('selectedItemsToDisplay : ', selectedItemsToDisplay);
    }
    //************************************************************************************** */

    @wire(getInitialData)
    wiredData(result) {
        console.log('getInitialData', result);
        if (result.data) {
            this.data = result.data.languageOptions;
            this.SelectLang = this.data;
            console.log('SelectLang : ', this.SelectLang);

        }
    }



    lookupRecord(event) {
        console.log('OUTPUT : ', JSON.stringify(event.detail));
        this.contact['AccountId'] = event.detail.selectedRecord.Id;
    }


    handleChange(event) {

        const name = event.target.name;

        const value = event.target.value;

        this.contact[name] = value;

        if (event.target.name == 'Phone') {

            this.phone = event.target.value;

        }




    }

    handleclick() {

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

        if (this.phone && this.validphone == true) {

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

                this.contact = undefined;

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

        } else {

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

    handlecancel() {

        this.template.querySelector('form').reset();

    }


}