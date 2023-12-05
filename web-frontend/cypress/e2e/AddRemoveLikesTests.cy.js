import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUser from '../TestUser.js';

describe('Sign Up Tests', () => {
    it('Get Available Trends', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser.EMAIL}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser.PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.location('pathname').should('eq', '/home');
        cy.document().contains('For you');

        // TODO: Navigate to a page having tweets
        // Could be the user's profile after posting a tweet
        // Or a predefined profile with tweets

        cy.get(`[data-test=${HomePageKeys.tweetContainer}]`).should('be.visible').then(($el) => {
            cy.get($el).find(`[data-test=${HomePageKeys.tweetLikesCount}]`).then(($el) => {
            const likes = Number($el.text());
            
            // Click on the tweet likes count element to add a like
            cy.get($el).click();
            cy.wait(1000);
            cy.get($el).then(($el) => {
                const newLikes = Number($el.text());
                expect(newLikes).to.be.greaterThan(likes);
            });
        
            // Click on the tweet likes count element again to remove a like
            cy.get($el).click();
            cy.wait(1000);
        
            cy.get($el).then(($el) => {
                const newLikes = Number($el.text());
                expect(newLikes).to.be.lessThan(likes);
            });
            });
        });
    });
});
