import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUsers from '../TestUser.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
import SettingsPageSelectors from '../../src/shared/selectors/SettingsPage.js';
import ValidationErrors from '../../src/shared/errors/ValidationErrors.js';

function getSubstringBefore(string, char) {
    let index = string.indexOf(char);
    if (index === -1) {
        return string;
    } else {
        return string.substring(0, index);
    }
}

describe('Update Email', () => {
    it('Update email and revert', () => {
        cy.getTestToken().then((webHookToken) => {
            cy.visit(`/`);
            cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
            cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
                `${TestUsers[0].EMAIL}`
            );
            cy.wait(1000);
            cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
            cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
                `${TestUsers[0].PASSWORD}`
            );
            cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
            cy.get(
                `[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`
            ).click();
            cy.get(
                `[data-test="${SettingsPageSelectors.CHANGE_EMAIL_BUTTON}"]`
            ).click();
            cy.get(
                `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
            ).type(`${TestUsers[0].PASSWORD}`);
            cy.get(
                `[data-test="${SettingsPageSelectors.NEXT_BUTTON}"]`
            ).click();

            cy.get(
                `[data-test="${SettingsPageSelectors.NEW_EMAIL_FIELD}"]`
            ).type(`${webHookToken}@email.webhook.site`);
            cy.get(
                `[data-test="${SettingsPageSelectors.NEXT_BUTTON}"]`
            ).click();

            cy.getSignUpVerificationCode(webHookToken).then(
                (verificationCode) => {
                    cy.get(
                        `[data-test="${SettingsPageSelectors.VERIFICATION_CODE_FIELD}"]`
                    ).type(verificationCode);
                    cy.get(
                        `[data-test="${SettingsPageSelectors.NEXT_BUTTON}"]`
                    ).click();
                }
            );
            cy.wait(1000);
            cy.document().contains('Email is changed successfully');

            // Change to the previous email again
            cy.get(
                `[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`
            ).click();
            cy.get(
                `[data-test="${SettingsPageSelectors.CHANGE_EMAIL_BUTTON}"]`
            ).click();
            cy.get(
                `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
            ).type(`${TestUsers[0].PASSWORD}`);
            cy.get(
                `[data-test="${SettingsPageSelectors.NEXT_BUTTON}"]`
            ).click();

            cy.get(
                `[data-test="${SettingsPageSelectors.NEW_EMAIL_FIELD}"]`
            ).type(TestUsers[0].EMAIL);
            cy.get(
                `[data-test="${SettingsPageSelectors.NEXT_BUTTON}"]`
            ).click();

            cy.getSignUpVerificationCode(
                getSubstringBefore(TestUsers[0].EMAIL, '@')
            ).then((verificationCode) => {
                cy.get(
                    `[data-test="${SettingsPageSelectors.VERIFICATION_CODE_FIELD}"]`
                ).type(verificationCode);
                cy.get(
                    `[data-test="${SettingsPageSelectors.NEXT_BUTTON}"]`
                ).click();
            });
            cy.wait(1000);
            cy.document().contains('Email is changed successfully');
        });
    });

    it('Update email with invalid format', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUsers[0].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUsers[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.CHANGE_EMAIL_BUTTON}"]`
        ).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
        ).type(`${TestUsers[0].PASSWORD}`);
        cy.get(`[data-test="${SettingsPageSelectors.NEXT_BUTTON}"]`).click();

        const invalidTestEmail1 = 'test.io.com';
        const invalidTestEmail2 = 'test@io@epam.com';
        const invalidTestEmail3 = 'test(io"epam)example]com';
        const invalidTestEmail4 = '.test... io\today@epam.com ';

        cy.get(`[data-test="${SettingsPageSelectors.NEW_EMAIL_FIELD}"]`)
            .clear()
            .type(invalidTestEmail1);
        cy.document().contains(ValidationErrors.INVALID_EMAIL_ERROR);
        cy.get(`[data-test="${SettingsPageSelectors.NEW_EMAIL_FIELD}"]`)
            .find('input')
            .clear();

        cy.get(`[data-test="${SettingsPageSelectors.NEW_EMAIL_FIELD}"]`).type(
            invalidTestEmail2
        );
        cy.document().contains(ValidationErrors.INVALID_EMAIL_ERROR);
        cy.get(`[data-test="${SettingsPageSelectors.NEW_EMAIL_FIELD}"]`)
            .find('input')
            .clear();

        cy.get(`[data-test="${SettingsPageSelectors.NEW_EMAIL_FIELD}"]`).type(
            invalidTestEmail3
        );
        cy.document().contains(ValidationErrors.INVALID_EMAIL_ERROR);
        cy.get(`[data-test="${SettingsPageSelectors.NEW_EMAIL_FIELD}"]`)
            .find('input')
            .clear();

        cy.get(`[data-test="${SettingsPageSelectors.NEW_EMAIL_FIELD}"]`).type(
            invalidTestEmail4
        );
        cy.document().contains(ValidationErrors.INVALID_EMAIL_ERROR);
    });

    it('Update email with empty untrimmed', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUsers[0].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUsers[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.CHANGE_EMAIL_BUTTON}"]`
        ).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
        ).type(`${TestUsers[0].PASSWORD}`);
        cy.get(`[data-test="${SettingsPageSelectors.NEXT_BUTTON}"]`).click();

        const invalidTestEmail = '     ';

        cy.get(`[data-test="${SettingsPageSelectors.NEW_EMAIL_FIELD}"]`)
            .clear()
            .type(invalidTestEmail);
        cy.document().contains(ValidationErrors.EMPTY_EMAIL_ERROR);
    });

    it('Update email with wrong code', () => {
        cy.getTestToken().then((webHookToken) => {
            cy.visit(`/`);
            cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
            cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
                `${TestUsers[0].EMAIL}`
            );
            cy.wait(1000);
            cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
            cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
                `${TestUsers[0].PASSWORD}`
            );
            cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
            cy.get(
                `[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`
            ).click();
            cy.get(
                `[data-test="${SettingsPageSelectors.CHANGE_EMAIL_BUTTON}"]`
            ).click();
            cy.get(
                `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
            ).type(`${TestUsers[0].PASSWORD}`);
            cy.get(
                `[data-test="${SettingsPageSelectors.NEXT_BUTTON}"]`
            ).click();

            cy.get(
                `[data-test="${SettingsPageSelectors.NEW_EMAIL_FIELD}"]`
            ).type(`${webHookToken}@email.webhook.site`);
            cy.get(
                `[data-test="${SettingsPageSelectors.NEXT_BUTTON}"]`
            ).click();

            const emptyUntrimmedCode = ' ';
            const shortCode = '1234';

            cy.get(
                `[data-test="${SettingsPageSelectors.VERIFICATION_CODE_FIELD}"]`
            ).type(emptyUntrimmedCode);

            cy.document().contains(ValidationErrors.EMPTY_CODE_ERROR);
            cy.get(
                `[data-test="${SettingsPageSelectors.VERIFICATION_CODE_FIELD}"]`
            )
                .find('input')
                .clear();

            cy.get(
                `[data-test="${SettingsPageSelectors.VERIFICATION_CODE_FIELD}"]`
            ).type(shortCode);

            cy.document().contains(ValidationErrors.CODE_LENGTH_ERROR);
        });
    });
});
