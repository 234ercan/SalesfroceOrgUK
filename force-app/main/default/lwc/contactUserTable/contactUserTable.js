import { LightningElement, api, track, wire} from 'lwc';
import getUserByEmail from '@salesforce/apex/contactUserListController.getUserInfoByEmail';

export default class ContactUserTable extends LightningElement {

   @api recordId;
   @api showContactEmailError=false;
   @api showUserError=false;
   @track data;
   @wire (getUserByEmail, { contactId: '$recordId' })
   handleUserResponse({ error, data }) {
      if (data) {
          this.data = data;
      } else if (error) {
          console.error(error);
      } else{
            if(!recordId==null){
               this.showContactEmailError=true;
            }else if(!data[0].email==null){
               this.showUserError=true;
            }
      }
}
}