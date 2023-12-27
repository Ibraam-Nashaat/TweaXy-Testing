import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUser from '../TestUser.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
import SettingsPageSelectors from '../../src/shared/selectors/SettingsPage.js';
import UpdateUsernameErrors from '../../src/shared/errors/UpdateUsernameErrors.js';

describe('Update Username:', () => {
    it('Update username successfully', () => {
        var newUsername = TestUser[3].USERNAME + Math.floor(Math.random() * 90);
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[3].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[3].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.UPDATE_USERNAME_BUTTON}"]`
        ).click();
        cy.get(`[data-test="${SettingsPageSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[3].PASSWORD}`
        );
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_PASSWORD_BUTTON}"]`
        ).click();
        cy.get(`[data-test="${SettingsPageSelectors.USERNAME_FIELD}"]`).type(
            newUsername
        );
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_USERNAME_BUTTON}"]`
        ).click();
        cy.document().contains('username is changed successfully');
        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.document().contains(newUsername);
    });

    it('Update username with wrong password', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[3].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[3].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.UPDATE_USERNAME_BUTTON}"]`
        ).click();
        cy.get(`[data-test="${SettingsPageSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[2].PASSWORD}`
        );
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_PASSWORD_BUTTON}"]`
        ).click();
        cy.document().contains(UpdateUsernameErrors.WRONG_PASSWORD);
        cy.document().contains('Confirm your password');
    });

    it('Update username with wrong username format', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[3].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[3].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.UPDATE_USERNAME_BUTTON}"]`
        ).click();
        cy.get(`[data-test="${SettingsPageSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[3].PASSWORD}`
        );
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_PASSWORD_BUTTON}"]`
        ).click();

        // Username is short
        cy.get(`[data-test="${SettingsPageSelectors.USERNAME_FIELD}"]`).type(
            'Mik'
        );
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_USERNAME_BUTTON}"]`
        ).click();
        cy.document().contains(UpdateUsernameErrors.USERNAME_LENGTH_ERROR);
        cy.document().contains('Confirm');

        // Username contains spaces
        cy.get(`[data-test="${SettingsPageSelectors.USERNAME_FIELD}"]`).type(
            'Mikasa Ackerman'
        );
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_USERNAME_BUTTON}"]`
        ).click();
        cy.document().contains(UpdateUsernameErrors.USERNAME_LENGTH_ERROR);
        cy.document().contains('Confirm');
    });

    it('Update username with used username', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[3].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[3].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.UPDATE_USERNAME_BUTTON}"]`
        ).click();
        cy.get(`[data-test="${SettingsPageSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[3].PASSWORD}`
        );
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_PASSWORD_BUTTON}"]`
        ).click();

        cy.get(`[data-test="${SettingsPageSelectors.USERNAME_FIELD}"]`).type(
            TestUser[2].USERNAME
        );
        cy.get(
            `[data-test="${SettingsPageSelectors.CONFIRM_USERNAME_BUTTON}"]`
        ).click();
        cy.document().contains(UpdateUsernameErrors.USERNAME_EXISTS);
        cy.document().contains('Confirm');
    });
});
