import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
import ProfilePageSelectors from '../../src/shared/selectors/ProfilePage.js';
import TestUsers from '../TestUser.js';

describe('Get Likes list', () => {
    it('Get signedin user likes list', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUsers[0].USERNAME}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUsers[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.get(`[data-test="${ProfilePageSelectors.LIKES_TAB}"]`).click();
        cy.wait(1000);
        cy.get(".tweet").should('exist').should('have.length.greaterThan', 0);
    });

    it('Get other user likes list', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUsers[0].USERNAME}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUsers[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.wait(2000);
        cy.get(`[data-test="${HomePageSelectors.SEARCH_BAR}"]`).type(
            `${TestUsers[1].USERNAME}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${TestUsers[1].USERNAME}-${HomePageSelectors.USER_SEARCH_ITEM}"]`).click();
        cy.wait(1000);
        cy.get(`[data-test="${ProfilePageSelectors.LIKES_TAB}"]`).click();
        cy.wait(1000);
        cy.get(".tweet").should('exist').should('have.length.greaterThan', 0);
    });
});
