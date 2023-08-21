import { LightningElement, wire, api, track } from 'lwc';
import getUserInfoByEmail from '@salesforce/apex/ContactUserController.getUserInfoByEmail';

export default class ContactUserInfo extends LightningElement {
    @api recordId;
    @api userFound = false;
    @api contactHasNoEmail = false;
    @api userNotFound = false;
    @track userInfo ;

    @wire(getUserInfoByEmail, { contactId: '$recordId' })
    handleUserResponse({ error, data }) {
        if (data) {
            this.userFound = true;
            this.userInfo = data;
            console.log("user info " +data);
        } else if (error) {
            console.error(error);
        } else {
            // User not found or contact doesn't have an email
            const contactWithoutEmail = this.recordId && !this.userInfo.email;
            this.contactHasNoEmail = contactWithoutEmail;
            this.userNotFound = !contactWithoutEmail;
        }
    }
}
