import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUsers from '../TestUser.js';
import TweetSelectors from '../../src/shared/selectors/Tweets.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
import { hashText } from '../../src/shared/Utils.js';

describe('Get List of Likers and Retweeters', () => {
    it('Get List of Likers', () => {
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
        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.wait(2000);
        cy.get('.options-container.cian-hover').first().click()
        cy.get(`[data-test="${TweetSelectors.VIEW_POST_ANALYTICS}"]`).click();
    });
});
