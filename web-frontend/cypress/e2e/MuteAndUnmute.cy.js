import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUser from '../TestUser.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
import ProfilePageSelectors from '../../src/shared/selectors/ProfilePage.js';
import { hashText } from '../../src/shared/Utils.js';
import TweetSelectors from '../../src/shared/selectors/Tweets.js';
import SettingsPageSelectors from '../../src/shared/selectors/SettingsPage.js';

describe('Mute/Unmute tests:', () => {
    let user1Post = Math.random();
    let user2Post = Math.random();

    it('Mute user', () => {
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

        cy.get(`[data-test="${HomePageSelectors.TWEETBOX_FIELD}"]`).type(
            user1Post
        );
        cy.get(
            `[data-test="${HomePageSelectors.TWEETBOX_POST_BUTTON}"]`
        ).click();
        cy.wait(1000);
        cy.visit(`/home`);
        cy.document().contains(user1Post);

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

        cy.document().contains(user1Post);
        cy.document().contains(TestUser[2].USERNAME);

        //user 2 posts a tweet
        cy.get(`[data-test="${HomePageSelectors.TWEETBOX_FIELD}"]`).type(
            user2Post
        );
        cy.get(
            `[data-test="${HomePageSelectors.TWEETBOX_POST_BUTTON}"]`
        ).click();
        cy.wait(1000);
        cy.visit(`/home`);
        cy.document().contains(user2Post);
        cy.document().contains(user1Post);

        //user 2 mutes user 1
        cy.get(
            `[data-test="${hashText(
                TweetSelectors.TWEET_OPTIONS + TestUser[2].NAME + user1Post
            )}"]`
        ).click();

        cy.get(`[data-test="${TweetSelectors.MUTE_USER}"]`).click();

        cy.document().its('body.textContent').should('not.include', user1Post);
        cy.document().contains(user2Post);

        //Check muted users list
        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.MUTED_ACCOUNTS_LIST_BUTTON}"]`
        ).click();
        cy.document().contains(TestUser[2].USERNAME);

        //sign out
        cy.get(`[data-test="${HomePageSelectors.ACCOUNT_BUTTON}"]`).click();
        cy.get(`[data-test="${HomePageSelectors.LOGOUT_BUTTON}"]`).click();

        //Sign in to first user
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

        cy.document().contains(user2Post);
        cy.document().contains(user1Post);
    });

    it('Unmute user', () => {
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

        cy.get(`[data-test="${HomePageSelectors.SETTINGS_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SettingsPageSelectors.MUTED_ACCOUNTS_LIST_BUTTON}"]`
        ).click();
        cy.document().contains(TestUser[2].USERNAME);

        cy.get(
            `[data-test="${hashText(
                SettingsPageSelectors.UNMUTE_BUTTON + TestUser[2].USERNAME
            )}"]`
        ).click();
        cy.wait(2000);
        cy.visit('/settings/mute');
        cy.wait(2000);
        cy.document()
            .its('body.textContent')
            .should('not.include', TestUser[2].USERNAME);

        cy.visit(`/home`);
        cy.document().contains(user2Post);
        cy.document().contains(user1Post);
    });
});
