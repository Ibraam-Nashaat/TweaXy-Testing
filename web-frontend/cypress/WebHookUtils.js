// Define the WebHookUtils class
export default class WebHookUtils {
    // Initialize the token property
    constructor() {
        this.token = '';
    }

    // Define the getTestEmail method
    async getTestEmail() {
        // If the token is empty, request a new one
        if (this.token == '') {
            const tokenResponse = await fetch('https://webhook.site/token', {
                method: 'POST',
            });
            const tokenData = await tokenResponse.json();
            this.token = tokenData['uuid'];
        }
        // Return the test email address
        return `${this.token}@email.webhook.site`;
    }

    // Define the getSignUpToken method
    async getSignUpToken() {
        // Get the latest request from the token
        const tokenResponse = await fetch(
            `https://webhook.site/token/${this.token}/request/latest`
        );
        const tokenData = await tokenResponse.json();
        // Return the sign up token from the subject header
        return tokenData['headers']['subject'][0].substring(0, 8);
    }

    // Define the getTokenString method
    async getTokenString() {
        // If the token is empty, request a new one
        if (this.token == '') {
            const tokenResponse = await fetch('https://webhook.site/token', {
                method: 'POST',
            });
            const tokenData = await tokenResponse.json();
            this.token = tokenData['uuid'];
        }
        // Return the token string
        return this.token;
    }
}
