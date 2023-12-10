import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUser from '../TestUser.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
import ProfilePageSelectors from '../../src/shared/selectors/ProfilePage.js';

describe('Tweets Tests:', () => {
    it('Add Tweet successfully', () => {
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

        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.wait(1000);
        cy.document().contains(post);

        cy.get(`[data-test="${HomePageSelectors.ACCOUNT_BUTTON}"]`).click();
        cy.get(`[data-test="${HomePageSelectors.LOGOUT_BUTTON}"]`).click();

        // Sign in with another account to check if post is reflected on followers feed
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

        cy.document().contains(post);
        cy.document().contains(TestUser[2].USERNAME);
    });
});
