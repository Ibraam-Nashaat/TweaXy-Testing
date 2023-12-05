import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUser from '../TestUser.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
import ProfilePageSelectors from '../../src/shared/selectors/ProfilePage.js';

describe('Edit Profile:', () => {
    it('Edit profile successfully', () => {
        //Sign in
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[1].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[1].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.get(
            `[data-test="${ProfilePageSelectors.EDIT_PROFILE_BUTTON}"]`
        ).click();

        //Clear all fields
        cy.get(`[data-test="${ProfilePageSelectors.NAME_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.BIO_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.LOCATION_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            '{selectall}{backspace}'
        );

        //Type new data
        cy.get(`[data-test="${ProfilePageSelectors.NAME_FIELD}"]`).type(
            `Kalawy`
        );
        cy.get(`[data-test="${ProfilePageSelectors.BIO_FIELD}"]`).type(`Abzo`);
        cy.get(`[data-test="${ProfilePageSelectors.LOCATION_FIELD}"]`).type(
            `Egypt`
        );
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            `http://google.com`
        );
        cy.get(`[data-test="${ProfilePageSelectors.SAVE_BUTTON}"]`).click();
    });
});
