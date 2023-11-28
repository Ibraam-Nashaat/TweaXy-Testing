import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUser from '../TestUser.js';
import ForgetPasswordErrors from '../../src/shared/errors/ForgetPasswordErrors.js';
import ValidationErrors from '../../src/shared/errors/ValidationErrors.js';
describe('Forget password Tests', () => {
    it('Change password successfully', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_BUTTON}"]`
        ).click();
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_EMAIL_FIELD}"]`
        ).type(`${TestUser[1].EMAIL}`);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.wait(2000);
        cy.getResetPasswordVerificationCode().then((verificationCode) => {
            cy.get(
                `[data-test="${SignInSelectors.FORGET_PASSWORD_VERIFICATION_FIELD}"]`
            ).type(`${verificationCode}`);
        });
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_NEW_PASSWORD_FIELD}"]`
        ).type('Kalawy@1234');
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_CONFIRM_PASSWORD_FIELD}"]`
        ).type('Kalawy@1234');
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.location('pathname').should('eq', '/home');
        cy.document().contains('For you');
        cy.wait(2000);
    });

    it('Change password with unregistered email', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_BUTTON}"]`
        ).click();
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_EMAIL_FIELD}"]`
        ).type(`Ahmed@gmail.com`);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.location('pathname').should('eq', '/forget-password');
        cy.document().contains(`${ForgetPasswordErrors.UNREGISTERED_EMAIL}`);
        cy.wait(2000);
    });

    it('Change password with wrong verification code', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_BUTTON}"]`
        ).click();
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_EMAIL_FIELD}"]`
        ).type(`${TestUser[1].EMAIL}`);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.wait(2000);
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_VERIFICATION_FIELD}"]`
        ).type(`598df238`);
        cy.location('pathname').should('eq', '/forget-password');
        cy.document().contains(
            `${ForgetPasswordErrors.WRONG_VERIFICATION_CODE}`
        );
        cy.wait(2000);
    });

    it('Change password with unmatching new password and confirmation new password', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_BUTTON}"]`
        ).click();
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_EMAIL_FIELD}"]`
        ).type(`${TestUser[1].EMAIL}`);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.wait(2000);
        cy.getResetPasswordVerificationCode().then((verificationCode) => {
            cy.get(
                `[data-test="${SignInSelectors.FORGET_PASSWORD_VERIFICATION_FIELD}"]`
            ).type(`${verificationCode}`);
        });
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_NEW_PASSWORD_FIELD}"]`
        ).type('Kalawy@1234');
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_CONFIRM_PASSWORD_FIELD}"]`
        ).type('Kalawy@1245');
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.location('pathname').should('eq', '/forget-password');
        cy.document().contains(
            `${ForgetPasswordErrors.UNMATCHING_PASSWORD_AND_CONFIRMATION_PASSWORD}`
        );
        cy.wait(2000);
    });

    it('Change password with new password having different validation errors', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_BUTTON}"]`
        ).click();
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_EMAIL_FIELD}"]`
        ).type(`${TestUser[1].EMAIL}`);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.wait(2000);
        cy.getResetPasswordVerificationCode().then((verificationCode) => {
            cy.get(
                `[data-test="${SignInSelectors.FORGET_PASSWORD_VERIFICATION_FIELD}"]`
            ).type(`${verificationCode}`);
        });
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        // Password length error
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_NEW_PASSWORD_FIELD}"]`
        ).type('Kalawy');
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_CONFIRM_PASSWORD_FIELD}"]`
        ).type('Kalawy');
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.location('pathname').should('eq', '/forget-password');
        cy.document().contains(`${ValidationErrors.PASSWORD_LENGTH_ERROR}`);

        // Password missing special character error
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_NEW_PASSWORD_FIELD}"]`
        ).type('Kalawy12');
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_CONFIRM_PASSWORD_FIELD}"]`
        ).type('Kalawy12');
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.location('pathname').should('eq', '/forget-password');
        cy.document().contains(
            `${ValidationErrors.PASSWORD_SPECIAL_CHARACTER_ERROR}`
        );

        //Password missing capital letter error
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_NEW_PASSWORD_FIELD}"]`
        ).type('kalawy@1234');
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_CONFIRM_PASSWORD_FIELD}"]`
        ).type('kalawy@1234');
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.location('pathname').should('eq', '/forget-password');
        cy.document().contains(
            `${ValidationErrors.PASSWORD_CAPITAL_LETTER_ERROR}`
        );

        // Password missing number error
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_NEW_PASSWORD_FIELD}"]`
        ).type('Kalawy@K');
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_CONFIRM_PASSWORD_FIELD}"]`
        ).type('Kalawy@K');
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.location('pathname').should('eq', '/forget-password');
        cy.document().contains(`${ValidationErrors.PASSWORD_NUMBER_ERROR}`);

        // Password missing small letter error
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_NEW_PASSWORD_FIELD}"]`
        ).type('KALAWY@1234');
        cy.get(
            `[data-test="${SignInSelectors.FORGET_PASSWORD_CONFIRM_PASSWORD_FIELD}"]`
        ).type('KALAWY@1234');
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.location('pathname').should('eq', '/forget-password');
        cy.document().contains(
            `${ValidationErrors.PASSWORD_SMALL_LETTER_ERROR}`
        );
        cy.wait(2000);
    });
});
