// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add('login', (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add('drag', { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add('dismiss', { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite('visit', (originalFn, url, options) => { ... })
Cypress.Commands.add('getResetPasswordVerificationCode', () => {
    const CYPRESS_WEBHOOK_TOKEN = 'ae05f13a-0271-4aa3-b6d2-de98a3838d73';
    // Wait for the webhook to be triggered and return the verification code
    cy.wait(20000); // Adjust this time based on the expected delay of the webhook

    // Make a request to the webhook to get the latest request data
    return cy
        .request({
            method: 'GET',
            url: `https://webhook.site/token/${CYPRESS_WEBHOOK_TOKEN}/request/latest`, // Replace with your actual webhook token
        })
        .then((response) => {
            // Validate the response
            expect(response.status).to.eq(200);

            // Assuming the response body is in JSON format
            const tokenData = response.body;
            const html = tokenData.text_content;

            // Parse the HTML to extract the verification code
            const document = new DOMParser().parseFromString(html, 'text/html');
            const verificationCode = document.querySelector('h4').textContent;
            return verificationCode;
        });
});

Cypress.Commands.add('getTestToken', () => {
    return cy
        .request({
            method: 'POST',
            url: `https://webhook.site/token`,
        })
        .then((response) => {
            const tokenData = response.body;
            return tokenData.uuid;
        });
});

Cypress.Commands.add('getSignUpVerificationCode', (token) => {
    cy.wait(20000);
    return cy
        .request({
            method: 'GET',
            url: `https://webhook.site/token/${token}/request/latest`,
        })
        .then((response) => {
            const tokenData = response.body;
            return tokenData['headers']['subject'][0].substring(0, 8);
        });
});
