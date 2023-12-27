import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUser from '../TestUser.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';

describe('Search Tweets Tests:', () => {
    let post = 'This is tweet ' + Math.random();

    it('Search for a tweet posted by the same user', () => {
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

        cy.get(`[data-test="${HomePageSelectors.TWEETBOX_FIELD}"]`).type(post);
        cy.get(
            `[data-test="${HomePageSelectors.TWEETBOX_POST_BUTTON}"]`
        ).click();
        cy.wait(1000);
        cy.visit(`/home`);
        cy.document().contains(post);

        cy.get(`[data-test="${HomePageSelectors.SEARCH_FIELD}"]`).type(
            `${post}{enter}`
        );
        cy.document().contains(post);
    });

    it('Search for a tweet posted by different user', () => {
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

        cy.document().contains(post);

        cy.get(`[data-test="${HomePageSelectors.SEARCH_FIELD}"]`).type(
            `${post}{enter}`
        );
        cy.document().contains(post);
    });
});
