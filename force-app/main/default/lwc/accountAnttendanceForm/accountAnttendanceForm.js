import { LightningElement, track } from 'lwc';
export default class AccountAnttendanceForm extends LightningElement {
@track fromChild = 'hello developer';
handleClickPresent(){
         this.fromChild = 'Student is Present';
}
handleClickAbsent(){
         this.fromChild = 'Student is Absent';
}
}