import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUsers from '../TestUser.js';
import TweetSelectors from '../../src/shared/selectors/Tweets.js';

describe('Add Remove Likes Tests', () => {
    it('Add and Remove Like Test', () => {
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

        cy.get(`[data-test=${TweetSelectors.TWEET}]`).first().should('be.visible').then(($el) => {
            cy.get($el).find(`[data-test=${TweetSelectors.TWEET_LIKES_COUNT}]`).then(($el2) => {
            const likes = Number($el2.text());
            
            // Click on the tweet likes count element to add a like
            cy.get(`[data-test=${TweetSelectors.LIKES_BUTTON}]`).first().click();
            cy.wait(1000);
            cy.get($el2).then(($el3) => {
                const newLikes = Number($el3.text());
                expect(newLikes).to.be.greaterThan(likes);
            });

            // Click on the tweet likes count element to remove the like
            cy.get(`[data-test=${TweetSelectors.LIKES_BUTTON}]`).first().click();
            cy.wait(1000);
            cy.get($el2).then(($el3) => {
                const newLikes = Number($el3.text());
                expect(newLikes).to.be.equal(likes);
            });
        
            });
        });
    });
});
