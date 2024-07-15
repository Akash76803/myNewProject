import { LightningElement, track, wire, api } from 'lwc';
export default class NewContact extends LightningElement {
@track contact = {};

handlechange(event) {
    const name = event.target.name;
    const value = event.target.value;
    switch (name) {
        case 'FirstName':
    this.contact['FirstName'] = value;
            break;
        case 'LastName':
           this.contact['LastName'] = value;
            break;
            default:
            break;

    }

}
}