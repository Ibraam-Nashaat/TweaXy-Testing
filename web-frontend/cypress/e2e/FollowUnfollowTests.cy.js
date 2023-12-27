import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
import ProfilePageSelectors from '../../src/shared/selectors/ProfilePage.js';
import UsersCellsSelectors from '../../src/shared/selectors/UsersCells.js';

describe('Follow and Unfollow tests', () => {
    it('Follow valid users', () => {
        cy.fixture('usersToFollow.json').as('usersToFollow');
        cy.fixture('usersToBeFollowed.json').as('usersToBeFollowed');
        cy.get('@usersToFollow').each((testUser) => {
            //Sign in
            cy.visit(`/`);
            cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
            cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
                `${testUser.USERNAME}`
            );
            cy.wait(1000);
            cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
            cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
                `${testUser.PASSWORD}`
            );
            cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

            cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
            cy.get(`[data-test="${ProfilePageSelectors.FOLLOWING_COUNT}"]`)
                .invoke('text')
                .then((text) => {
                    let followingCount = parseInt(text.trim());
                    cy.get('@usersToBeFollowed').each((userToFollow) => {
                        cy.get(`[data-test="${HomePageSelectors.SEARCH_BAR}"]`).type(
                            `${userToFollow.USERNAME}`
                        );
                        cy.wait(1000);
                        cy.get(`[data-test="${userToFollow.USERNAME}-${HomePageSelectors.USER_SEARCH_ITEM}"]`).click();
                        cy.reload()
                        cy.wait(3000);
                        cy.get(
                            `[data-test="${ProfilePageSelectors.FOLLOW_UNFOLLOW_BUTTON}"]`
                        )
                            .invoke('text')
                            .then((buttonState) => {
                                const profileButtonState = buttonState.trim();
                                if (profileButtonState === 'Follow') {
                                    cy.get(
                                        `[data-test="${ProfilePageSelectors.FOLLOW_UNFOLLOW_BUTTON}"]`
                                    ).click();
                                    followingCount++;
                                }
                            });
                    });
                    cy.get(
                        `[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`
                    ).click();
                    cy.reload();
                    cy.wait(2000);
                    cy.get(
                        `[data-test="${ProfilePageSelectors.FOLLOWING_COUNT}"]`
                    )
                        .invoke('text')
                        .then((newCount) => {
                            expect(parseInt(newCount)).to.equal(followingCount);
                        });
                });

            cy.get(`[data-test="${HomePageSelectors.ACCOUNT_BUTTON}"]`).click();
            cy.get(`[data-test="${HomePageSelectors.LOGOUT_BUTTON}"]`).click();
            cy.wait(2000);
        });
    });

    it('Unollow valid users', () => {
        cy.fixture('testUsers.json').as('testUsers');
        cy.get('@testUsers').each((testUser) => {
            //Sign in
            cy.visit(`/`);
            cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
            cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
                `${testUser.USERNAME}`
            );
            cy.wait(1000);
            cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
            cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
                `${testUser.PASSWORD}`
            );
            cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

            cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
            cy.get(`[data-test="${ProfilePageSelectors.FOLLOWING_COUNT}"]`)
                .invoke('text')
                .then((text) => {
                    const followersCount = parseInt(text.trim());
                    cy.get(
                        `[data-test="${ProfilePageSelectors.FOLLOWING_LINK}"]`
                    ).click();
                    cy.wait(2000);
                    if (followersCount == 0) {
                        cy.get(
                            `[data-test="${UsersCellsSelectors.MESSAGE_HEADER}"]`
                        ).should(
                            'have.text',
                            `@${testUser.USERNAME} isn't following anyone`
                        );
                    } else {
                        cy.get(`[data-test="${UsersCellsSelectors.USERNAME}"]`)
                            .first()
                            .invoke('text')
                            .then((usernameToUnfollow) => {
                                const username = usernameToUnfollow.trim();
                                cy.get(
                                    `[data-test="${UsersCellsSelectors.NAME}"]`
                                )
                                    .first()
                                    .click();
                                cy.wait(2000);  
                                cy.get(
                                    `[data-test="${ProfilePageSelectors.FOLLOW_UNFOLLOW_BUTTON}"]`
                                )
                                    .invoke('text')
                                    .then((buttonState) => {
                                        const profileButtonState =
                                            buttonState.trim();
                                        if (profileButtonState === 'Following') {
                                            cy.get(
                                                `[data-test="${ProfilePageSelectors.FOLLOW_UNFOLLOW_BUTTON}"]`
                                            ).click();
                                            cy.get(
                                                `[data-test="${ProfilePageSelectors.BACK_TO_PROFILE}"]`
                                            ).click();
                                            cy.wait(2000);
                                            cy.get(
                                                `[data-test=${UsersCellsSelectors.NAME}]`
                                            ).each(($el) => {
                                                expect($el.text()).not.to.eq(
                                                    username
                                                );
                                            });
                                        }
                                    });
                            });
                    }
                });

            cy.get(`[data-test="${HomePageSelectors.ACCOUNT_BUTTON}"]`).click();
            cy.get(`[data-test="${HomePageSelectors.LOGOUT_BUTTON}"]`).click();
            cy.wait(2000);
        });
    });

    it('Unfollow users from user cells', () => {
        cy.fixture('testUsers.json').as('testUsers');
        cy.get('@testUsers').each((testUser) => {
            //Sign in
            cy.visit(`/`);
            cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
            cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
                `${testUser.USERNAME}`
            );
            cy.wait(1000);
            cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
            cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
                `${testUser.PASSWORD}`
            );
            cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

            cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
            cy.get(`[data-test="${ProfilePageSelectors.FOLLOWING_COUNT}"]`)
                .invoke('text')
                .then((text) => {
                    // Do something with the text
                    const followersCount = parseInt(text.trim()); // convert text to a number and remove spaces
                    cy.get(
                        `[data-test="${ProfilePageSelectors.FOLLOWING_LINK}"]`
                    ).click();
                    cy.wait(2000);
                    if (followersCount == 0) {
                        cy.get(
                            `[data-test="${UsersCellsSelectors.MESSAGE_HEADER}"]`
                        ).should(
                            'have.text',
                            `@${testUser.USERNAME} isn't following anyone`
                        );
                    } else {
                        cy.get(
                            `[data-test="${UsersCellsSelectors.FOLLOW_UNFOLLOW_BUTTON}"]`
                        ).each(($el, index) => {
                            // alias the current element as followButton
                            cy.wrap($el).as('followButton');
                            // check if the element bcd has a text of follow
                            cy.get('@followButton').should(
                                'have.text',
                                'Following'
                            );
                            // click on the element bcd
                            cy.get('@followButton').click();
                            // wait 2 seconds
                            cy.wait(2000);
                            // check if the text became unfollow
                            cy.get('@followButton').should(
                                'have.text',
                                'Follow'
                            );
                        });
                    }
                });

            cy.get(`[data-test="${HomePageSelectors.ACCOUNT_BUTTON}"]`).click();
            cy.get(`[data-test="${HomePageSelectors.LOGOUT_BUTTON}"]`).click();
            cy.wait(2000);
        });
    });
});
