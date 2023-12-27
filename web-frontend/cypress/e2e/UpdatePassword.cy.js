import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUser from '../TestUser.js';
import ForgetPasswordErrors from '../../src/shared/errors/ForgetPasswordErrors.js';
import SettingsPageSelectors from '../../src/shared/selectors/SettingsPage.js';
import UpdatePasswordErrors from '../../src/shared/errors/UpdatePasswordErrors.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
describe('Update password Tests', () => {
    it('Change password with unmatching new password and confirmation new password', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[2].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[2].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.CHANGE_PASSWORD_BUTTON}"]`
        ).click();

        cy.get(
            `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
        ).type(TestUser[2].PASSWORD);
        cy.get(
            `[data-test="${SettingsPageSelectors.NEW_PASSWORD_FIELD}"]`
        ).type(TestUser[2].NEW_PASSWORD);
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_NEW_PASSWORD_FIELD}"]`
        ).type('Levi@123456798');

        cy.document()
            .its('body.textContent')
            .should(
                'include',
                UpdatePasswordErrors.UNMATCHING_PASSWORD_AND_CONFIRMATION_PASSWORD
            );
    });

    it('Change password with new password as current password', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[2].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[2].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.CHANGE_PASSWORD_BUTTON}"]`
        ).click();

        cy.get(
            `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
        ).type(TestUser[2].PASSWORD);
        cy.get(
            `[data-test="${SettingsPageSelectors.NEW_PASSWORD_FIELD}"]`
        ).type(TestUser[2].PASSWORD);
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_NEW_PASSWORD_FIELD}"]`
        ).type(TestUser[2].PASSWORD);
        cy.get(`[data-test="${SettingsPageSelectors.SAVE_BUTTON}"]`).click();

        cy.document()
            .its('body.textContent')
            .should(
                'include',
                UpdatePasswordErrors.NEW_PASSWORD_MATCHED_OLD_PASSWORD
            );
    });

    it('Change password with wrong current password', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[2].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[2].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.CHANGE_PASSWORD_BUTTON}"]`
        ).click();

        cy.get(
            `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
        ).type('Levi@156456456_');
        cy.get(
            `[data-test="${SettingsPageSelectors.NEW_PASSWORD_FIELD}"]`
        ).type(TestUser[2].NEW_PASSWORD);
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_NEW_PASSWORD_FIELD}"]`
        ).type(TestUser[2].NEW_PASSWORD);
        cy.get(`[data-test="${SettingsPageSelectors.SAVE_BUTTON}"]`).click();

        cy.document()
            .its('body.textContent')
            .should('include', UpdatePasswordErrors.WRONG_PASSWORD);
    });

    it('Change password with new password having different validation errors', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[2].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[2].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.CHANGE_PASSWORD_BUTTON}"]`
        ).click();

        // Password length error
        cy.get(
            `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
        ).type(TestUser[2].PASSWORD);
        cy.get(
            `[data-test="${SettingsPageSelectors.NEW_PASSWORD_FIELD}"]`
        ).type('Levi');
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_NEW_PASSWORD_FIELD}"]`
        ).type('Levi');
        cy.get(`[data-test="${SettingsPageSelectors.SAVE_BUTTON}"]`).click();

        cy.document()
            .its('body.textContent')
            .should('include', UpdatePasswordErrors.PASSWORD_LENGTH_ERROR);

        // Password missing special character error
        cy.visit(`/settings/password`);

        cy.get(
            `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
        ).type(TestUser[2].PASSWORD);
        cy.get(
            `[data-test="${SettingsPageSelectors.NEW_PASSWORD_FIELD}"]`
        ).type('Levi1234');
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_NEW_PASSWORD_FIELD}"]`
        ).type('Levi1234');
        cy.get(`[data-test="${SettingsPageSelectors.SAVE_BUTTON}"]`).click();

        cy.document()
            .its('body.textContent')
            .should(
                'include',
                UpdatePasswordErrors.PASSWORD_SPECIAL_CHARACTER_ERROR
            );

        //Password missing capital letter error
        cy.visit(`/settings/password`);

        cy.get(
            `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
        ).type(TestUser[2].PASSWORD);
        cy.get(
            `[data-test="${SettingsPageSelectors.NEW_PASSWORD_FIELD}"]`
        ).type('levi@1234');
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_NEW_PASSWORD_FIELD}"]`
        ).type('levi@1234');
        cy.get(`[data-test="${SettingsPageSelectors.SAVE_BUTTON}"]`).click();

        cy.document()
            .its('body.textContent')
            .should(
                'include',
                UpdatePasswordErrors.PASSWORD_CAPITAL_LETTER_ERROR
            );

        // Password missing number error
        cy.visit(`/settings/password`);

        cy.get(
            `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
        ).type(TestUser[2].PASSWORD);
        cy.get(
            `[data-test="${SettingsPageSelectors.NEW_PASSWORD_FIELD}"]`
        ).type('Levi@_()');
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_NEW_PASSWORD_FIELD}"]`
        ).type('Levi@_()');
        cy.get(`[data-test="${SettingsPageSelectors.SAVE_BUTTON}"]`).click();

        cy.document()
            .its('body.textContent')
            .should('include', UpdatePasswordErrors.PASSWORD_NUMBER_ERROR);

        // Password missing small letter error

        cy.visit(`/settings/password`);

        cy.get(
            `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
        ).type(TestUser[2].PASSWORD);
        cy.get(
            `[data-test="${SettingsPageSelectors.NEW_PASSWORD_FIELD}"]`
        ).type('LEVI@12345');
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_NEW_PASSWORD_FIELD}"]`
        ).type('LEVI@12345');
        cy.get(`[data-test="${SettingsPageSelectors.SAVE_BUTTON}"]`).click();

        cy.document()
            .its('body.textContent')
            .should(
                'include',
                UpdatePasswordErrors.PASSWORD_SMALL_LETTER_ERROR
            );
        cy.wait(2000);
    });

    it('Change password successfully', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[2].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[2].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.CHANGE_PASSWORD_BUTTON}"]`
        ).click();

        cy.get(
            `[data-test="${SettingsPageSelectors.CURRENT_PASSWORD_FIELD}"]`
        ).type(TestUser[2].PASSWORD);
        cy.get(
            `[data-test="${SettingsPageSelectors.NEW_PASSWORD_FIELD}"]`
        ).type(TestUser[2].NEW_PASSWORD);
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_NEW_PASSWORD_FIELD}"]`
        ).type(TestUser[2].NEW_PASSWORD);
        cy.get(`[data-test="${SettingsPageSelectors.SAVE_BUTTON}"]`).click();

        cy.wait(2000);

        cy.get(`[data-test="${HomePageSelectors.ACCOUNT_BUTTON}"]`).click();
        cy.get(`[data-test="${HomePageSelectors.LOGOUT_BUTTON}"]`).click();

        //sign in with new password

        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[2].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[2].NEW_PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.location('pathname').should('eq', '/home');
    });
});
