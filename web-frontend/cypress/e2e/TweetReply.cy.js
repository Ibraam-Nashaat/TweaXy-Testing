import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUser from '../TestUser.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
import { hashText } from '../../src/shared/Utils.js';
import TweetSelectors from '../../src/shared/selectors/Tweets.js';

describe('Tweets Reply Tests:', () => {
    let post = 'This is tweet ' + Math.random();
    let user1Reply = 'This is user1Reply ' + Math.random();
    let user2Reply = 'This is user2Reply ' + Math.random();

    it('Add Replies to a tweet', () => {
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
        cy.visit('/home');
        cy.document().contains(post);

        cy.get(
            `[data-test="${hashText(
                TweetSelectors.TWEET_TEXT + TestUser[2].NAME + post
            )}"]`
        ).click();

        cy.document().contains(post);

        cy.get(`[data-test="${TweetSelectors.TWEET_REPLY_FIELD}"]`).click();
        cy.get(`[data-test="${TweetSelectors.TWEET_REPLY_FIELD}"]`).type(
            `${user1Reply}`
        );
        cy.get(`[data-test="${TweetSelectors.TWEET_REPLY_BUTTON}"]`).click();
        cy.wait(2000);
        cy.reload();
        cy.document().contains(post);
        cy.document().contains(user1Reply);

        cy.get(`[data-test="${HomePageSelectors.ACCOUNT_BUTTON}"]`).click();
        cy.get(`[data-test="${HomePageSelectors.LOGOUT_BUTTON}"]`).click();

        // Sign in with another account
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

        cy.get(
            `[data-test="${hashText(
                TweetSelectors.TWEET_TEXT + TestUser[2].NAME + post
            )}"]`
        ).click();

        cy.document().contains(post);
        cy.document().contains(user1Reply);

        cy.get(`[data-test="${TweetSelectors.TWEET_REPLY_FIELD}"]`).click();
        cy.get(`[data-test="${TweetSelectors.TWEET_REPLY_FIELD}"]`).type(
            `${user2Reply}`
        );
        cy.get(`[data-test="${TweetSelectors.TWEET_REPLY_BUTTON}"]`).click();
        cy.wait(2000);
        cy.reload();
        cy.document().contains(post);
        cy.document().contains(user1Reply);
        cy.document().contains(user2Reply);
        cy.get(`[data-test="${HomePageSelectors.ACCOUNT_BUTTON}"]`).click();
        cy.get(`[data-test="${HomePageSelectors.LOGOUT_BUTTON}"]`).click();

        //sign in to first user account
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

        cy.get(
            `[data-test="${hashText(
                TweetSelectors.TWEET_TEXT + TestUser[2].NAME + post
            )}"]`
        ).click();
        cy.document().contains(post);
        cy.document().contains(user1Reply);
        cy.document().contains(user2Reply);
        cy.wait(2000);

    });

    it('Delete Reply', () => {
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
        cy.visit('/home');
        cy.document().contains(post);

        cy.get(
            `[data-test="${hashText(
                TweetSelectors.TWEET_TEXT + TestUser[2].NAME + post
            )}"]`
        ).click();

        cy.document().contains(post);

        cy.get(`[data-test="${TweetSelectors.TWEET_REPLY_FIELD}"]`).click();
        cy.get(`[data-test="${TweetSelectors.TWEET_REPLY_FIELD}"]`).type(
            `${user1Reply}`
        );
        cy.get(`[data-test="${TweetSelectors.TWEET_REPLY_BUTTON}"]`).click();
        cy.wait(2000);
        cy.reload();
        cy.document().contains(post);
        cy.document().contains(user1Reply);


        cy.get(
            `[data-test="${hashText(
                TweetSelectors.TWEET_OPTIONS + TestUser[2].NAME + user1Reply
            )}"]`
        ).click();

        cy.get(`[data-test="${TweetSelectors.DELETE_TWEET}"]`).click();

        cy.get(`[data-test="${TweetSelectors.CONFIRM_DELETE_TWEET}"]`).click();
        cy.wait(1000);
        cy.reload();
        cy.document().contains(post);
        cy.document().its('body.textContent').should('not.include', user1Reply);
    });
});
