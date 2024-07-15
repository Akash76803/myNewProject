import { LightningElement, track, wire} from 'lwc';
import displayAccWithcon from '@salesforce/apex/Acccount_Example1.displayAccWithcon'
export default class HOMEPAGE_CMP1 extends LightningElement {

    @track accounts;
    @track error;
    @track search;

    handleChange(event){
        this.search = event.target.value;
    }
    
    @wire(displayAccWithcon, { searchkey: '$search' })
    wiredData({ error, data }) {
      if (data) {
          this.accounts = data;
        console.log('Data', data);
      } else if (error) {
          this.error = error;
         console.error('Error:', error);
      }
    }
}