import { LightningElement, api, wire, track } from 'lwc';
export default class Community extends LightningElement {

 @track input = 'Akash Gaikwad';
 @track input2;
    handleChangeInput(event) {
        this.input2 = event.target.value;
    }

    handleClick(event){
        this.input = this.input2;
    }

   
}