import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
import ProfilePageSelectors from '../../src/shared/selectors/ProfilePage.js';
import TestUsers from '../TestUser.js';
import SettingsPageSelectors from '../../src/shared/selectors/SettingsPage.js';

describe('Follow and Unfollow tests', () => {
    it('Add Block', () => {
        //Sign in
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUsers[0].USERNAME}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUsers[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.SEARCH_BAR}"]`).type(
            `${TestUsers[1].USERNAME}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${TestUsers[1].USERNAME}-${HomePageSelectors.USER_SEARCH_ITEM}"]`).click();
        cy.reload()
        cy.wait(3000);

        cy.get(`[data-test="${ProfilePageSelectors.MORE_OPTIONS_BUTTON}"]`).click();
        cy.wait(1000);
        cy.get(`[data-test="${ProfilePageSelectors.BLOCK_USER_BUTTON}"]`).click();
        cy.wait(1000);
        cy.get(`[data-test="${ProfilePageSelectors.BLOCK_USER_CONFIRM_BUTTON}"]`).click();

        cy.wait(5000);
        cy.get(`[data-test="${HomePageSelectors.ACCOUNT_BUTTON}"]`).click();
        cy.get(`[data-test="${HomePageSelectors.LOGOUT_BUTTON}"]`).click();
        cy.wait(2000);

        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUsers[1].USERNAME}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUsers[1].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.SEARCH_BAR}"]`).type(
            `${TestUsers[0].USERNAME}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${TestUsers[0].USERNAME}-${HomePageSelectors.USER_SEARCH_ITEM}"]`).should('not.exist');
    });
    it('View and remove Blocks', () => {
        //Sign in
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUsers[0].USERNAME}`
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
            `[data-test="${SettingsPageSelectors.MANAGE_BLOCKS_BUTTON}"]`
        ).click();
        cy.wait(2000);
        cy.get(
            `[data-test="${SettingsPageSelectors.UNBLOCK_USER_CELL_BUTTON}"]`
        ).click();
        cy.wait(2000);
        
        cy.get(`[data-test="${HomePageSelectors.ACCOUNT_BUTTON}"]`).click();
        cy.get(`[data-test="${HomePageSelectors.LOGOUT_BUTTON}"]`).click();
        cy.wait(2000);

        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUsers[1].USERNAME}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUsers[1].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.SEARCH_BAR}"]`).type(
            `${TestUsers[0].USERNAME}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${TestUsers[0].USERNAME}-${HomePageSelectors.USER_SEARCH_ITEM}"]`).should('exist');
    });
});
