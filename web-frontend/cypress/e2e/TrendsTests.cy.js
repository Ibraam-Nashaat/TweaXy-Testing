import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
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

        cy.get(`[data-test="${HomePageSelectors.TRENDING_SECTION}"]`)
            .should('exist')
            .find(`[data-test="${HomePageSelectors.TRENDING_ITEM}"]`)
            .should('have.length.greaterThan', 0);
    });
    it('Get trends tweets topic and number', () => {
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

        cy.get(`[data-test="${HomePageSelectors.TRENDING_ITEM}"]`).each(
            ($el) => {
                cy.wrap($el)
                    .find(`[data-test="${HomePageSelectors.TRENDING_TOPIC}"]`)
                    .should('exist')
                    .should('not.be.empty');
                cy.wrap($el)
                    .find(
                        `[data-test="${HomePageSelectors.TRENDING_TOPIC_NUMBER}"]`
                    )
                    .should('exist')
                    .should('not.eq', 0);
            }
        );
    });
});
