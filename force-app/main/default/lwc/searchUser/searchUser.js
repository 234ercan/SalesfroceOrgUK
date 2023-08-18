import { LightningElement, wire, api } from 'lwc';
import getUserInfoByEmail from '@salesforce/apex/ContactUserController.getUserInfoByEmail';

export default class ContactUserInfo extends LightningElement {
    @api contactId;
    userFound = false;
    contactHasNoEmail = false;
    userNotFound = false;
    userInfo = {};

    @wire(getUserInfoByEmail, { contactId: '$contactId' })
    handleUserResponse({ error, data }) {
        if (data) {
            this.userFound = true;
            this.userInfo = data;
        } else if (error) {
            console.error(error);
        } else {
            // User not found or contact doesn't have an email
            const contactWithoutEmail = this.contactId && !this.userInfo.email;
            this.contactHasNoEmail = contactWithoutEmail;
            this.userNotFound = !contactWithoutEmail;
        }
    }
}
