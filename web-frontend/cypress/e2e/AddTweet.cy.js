import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUser from '../TestUser.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';

describe('Add Tweet:', () => {
    it('Add Tweet successfully', () => {
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

        const post = Math.random();
        cy.get(`[data-test="${HomePageSelectors.TWEETBOX_FIELD}"]`).type(post);
        cy.get(
            `[data-test="${HomePageSelectors.TWEETBOX_POST_BUTTON}"]`
        ).click();
        cy.wait(3000);
        cy.reload();
        cy.wait(2000);
        cy.location('pathname').should('eq', '/home');
        cy.document().contains(post);
    });
});
