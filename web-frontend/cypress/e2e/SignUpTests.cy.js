import SignUpSelectors from '../../src/shared/selectors/SignUp.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import ValidationErrors from '../../src/shared/errors/ValidationErrors.js';

describe('Sign Up Tests', () => {
    it('SignUp with right inputs (Good Path)', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_UP}"]`).click();

        cy.getTestToken().then((webHookToken) => {
            cy.get(`[data-test="${SignUpSelectors.EMAIL_FIELD}"]`).type(
                `${webHookToken}@email.webhook.site`
            );
            cy.get(`[data-test="${SignUpSelectors.USERNAME_FIELD}"]`).type(
                `${webHookToken}`
            );
            const testName = 'Kalawy';
            cy.get(`[data-test="${SignUpSelectors.NAME_FIELD}"]`).type(
                `${testName}`
            );
            const testDay = 6;
            const testMonth = 2;
            const testYear = 2000;

            cy.get(`[data-test="${SignUpSelectors.DAY_FIELD}"]`).click();
            cy.get(
                `[data-test="${testDay}_${SignUpSelectors.MONTH_FIELD}"]`
            ).click();

            cy.get(`[data-test="${SignUpSelectors.MONTH_FIELD}"]`).click();
            cy.get(
                `[data-test="${testMonth}_${SignUpSelectors.MONTH_FIELD}"]`
            ).click();

            cy.get(`[data-test="${SignUpSelectors.YEAR_FIELD}"]`).click();
            cy.get(
                `[data-test="${testYear}_${SignUpSelectors.YEAR_FIELD}"]`
            ).click();

            cy.get(`[data-test="${SignUpSelectors.NEXT_BUTTON}"]`).click();
            cy.get(`[data-test="${SignUpSelectors.NEXT_BUTTON}"]`).click();
            cy.document().contains("We've sent you a verification code");
            cy.getSignUpVerificationCode(webHookToken).then(
                (verificationCode) => {
                    cy.get(
                        `[data-test="${SignUpSelectors.VERIFICATION_CODE_FIELD}"]`
                    ).type(verificationCode);
                }
            );
        });
        cy.get(`[data-test="${SignUpSelectors.NEXT_BUTTON}"]`).click();

        const testPassword = 'AaBb$Cc123';
        cy.get(`[data-test="${SignUpSelectors.PASSWORD_FIELD}"]`).type(
            testPassword
        );

        cy.get(`[data-test="${SignUpSelectors.NEXT_BUTTON}"]`).click();

        cy.location('pathname').should('eq', '/home');
        cy.document().contains('For you');
    });
    it('SignUp first page with untrimmed empty inputs', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_UP}"]`).click();

        cy.get(`[data-test="${SignUpSelectors.EMAIL_FIELD}"]`).type('   ');
        cy.document().contains(ValidationErrors.EMPTY_EMAIL_ERROR);
        cy.get(`[data-test="${SignUpSelectors.USERNAME_FIELD}"]`).type('   ');
        cy.document().contains(ValidationErrors.EMPTY_USERNAME_ERROR);
        cy.get(`[data-test="${SignUpSelectors.NAME_FIELD}"]`).type('    ');
        cy.document().contains(ValidationErrors.EMPTY_NAME_ERROR);

        const testDay = 6;
        const testMonth = 2;
        const testYear = 2000;

        cy.get(`[data-test="${SignUpSelectors.DAY_FIELD}"]`).click();
        cy.get(
            `[data-test="${testDay}_${SignUpSelectors.MONTH_FIELD}"]`
        ).click();

        cy.get(`[data-test="${SignUpSelectors.MONTH_FIELD}"]`).click();
        cy.get(
            `[data-test="${testMonth}_${SignUpSelectors.MONTH_FIELD}"]`
        ).click();

        cy.get(`[data-test="${SignUpSelectors.YEAR_FIELD}"]`).click();
        cy.get(
            `[data-test="${testYear}_${SignUpSelectors.YEAR_FIELD}"]`
        ).click();

        cy.get(`[data-test="${SignUpSelectors.NEXT_BUTTON}"]`).click();

        cy.location('pathname').should('eq', '/');
        cy.document().contains('Create your account');
    });
    it('SignUp with invalid inputs', () => {
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_UP}"]`).click();

        cy.getTestToken().then((webHookToken) => {
            const invalidTestEmail1 = 'test.io.com';
            const invalidTestEmail2 = 'test@io@epam.com';
            const invalidTestEmail3 = 'test(io"epam)example]com';
            const invalidTestEmail4 = '.test... io\today@epam.com ';

            cy.get(`[data-test="${SignUpSelectors.EMAIL_FIELD}"]`)
                .clear()
                .type(invalidTestEmail1);
            cy.document().contains(ValidationErrors.INVALID_EMAIL_ERROR);
            cy.get(`[data-test="${SignUpSelectors.EMAIL_FIELD}"]`)
                .find('input')
                .clear();

            cy.get(`[data-test="${SignUpSelectors.EMAIL_FIELD}"]`).type(
                invalidTestEmail2
            );
            cy.document().contains(ValidationErrors.INVALID_EMAIL_ERROR);
            cy.get(`[data-test="${SignUpSelectors.EMAIL_FIELD}"]`)
                .find('input')
                .clear();

            cy.get(`[data-test="${SignUpSelectors.EMAIL_FIELD}"]`).type(
                invalidTestEmail3
            );
            cy.document().contains(ValidationErrors.INVALID_EMAIL_ERROR);
            cy.get(`[data-test="${SignUpSelectors.EMAIL_FIELD}"]`)
                .find('input')
                .clear();

            cy.get(`[data-test="${SignUpSelectors.EMAIL_FIELD}"]`).type(
                invalidTestEmail4
            );
            cy.document().contains(ValidationErrors.INVALID_EMAIL_ERROR);
            cy.get(`[data-test="${SignUpSelectors.EMAIL_FIELD}"]`)
                .find('input')
                .clear();

            cy.get(`[data-test="${SignUpSelectors.EMAIL_FIELD}"]`).type(
                `${webHookToken}@email.webhook.site`
            );
            cy.document()
                .contains(ValidationErrors.INVALID_EMAIL_ERROR)
                .should('have.length', 0);

            cy.get(`[data-test="${SignUpSelectors.USERNAME_FIELD}"]`).type(
                `${webHookToken}`
            );
            cy.get('.error-message')
                .contains(ValidationErrors.USERNAME_LENGTH_ERROR)
                .should('have.length', 0);

            cy.document()
                .contains(ValidationErrors.EMPTY_USERNAME_ERROR)
                .should('have.length', 0);

            const testName = 'Kalawy';
            cy.get(`[data-test="${SignUpSelectors.NAME_FIELD}"]`).type(
                `${testName}`
            );
            cy.document()
                .contains(ValidationErrors.EMPTY_NAME_ERROR)
                .should('have.length', 0);

            const testDay = 6;
            const testMonth = 2;
            const testYear = 2000;

            cy.get(`[data-test="${SignUpSelectors.DAY_FIELD}"]`).click();
            cy.get(
                `[data-test="${testDay}_${SignUpSelectors.MONTH_FIELD}"]`
            ).click();

            cy.get(`[data-test="${SignUpSelectors.MONTH_FIELD}"]`).click();
            cy.get(
                `[data-test="${testMonth}_${SignUpSelectors.MONTH_FIELD}"]`
            ).click();

            cy.get(`[data-test="${SignUpSelectors.YEAR_FIELD}"]`).click();
            cy.get(
                `[data-test="${testYear}_${SignUpSelectors.YEAR_FIELD}"]`
            ).click();

            cy.get(`[data-test="${SignUpSelectors.NEXT_BUTTON}"]`).click();
            cy.get(`[data-test="${SignUpSelectors.NEXT_BUTTON}"]`).click();
            cy.document().contains("We've sent you a verification code");
            cy.getSignUpVerificationCode(webHookToken).then(
                (verificationCode) => {
                    const emptyUntrimmedCode = ' ';
                    const shortCode = '1234';

                    cy.get(
                        `[data-test="${SignUpSelectors.VERIFICATION_CODE_FIELD}"]`
                    ).type(emptyUntrimmedCode);

                    cy.document().contains(ValidationErrors.EMPTY_CODE_ERROR);
                    cy.get(
                        `[data-test="${SignUpSelectors.VERIFICATION_CODE_FIELD}"]`
                    )
                        .find('input')
                        .clear();

                    cy.get(
                        `[data-test="${SignUpSelectors.VERIFICATION_CODE_FIELD}"]`
                    ).type(shortCode);

                    cy.document().contains(ValidationErrors.CODE_LENGTH_ERROR);
                    cy.get(
                        `[data-test="${SignUpSelectors.VERIFICATION_CODE_FIELD}"]`
                    )
                        .find('input')
                        .clear();

                    cy.get(
                        `[data-test="${SignUpSelectors.VERIFICATION_CODE_FIELD}"]`
                    ).type(verificationCode);

                    cy.document()
                        .contains(ValidationErrors.CODE_LENGTH_ERROR)
                        .should('have.length', 0);
                    cy.document()
                        .contains(ValidationErrors.EMPTY_CODE_ERROR)
                        .should('have.length', 0);
                }
            );
        });
        cy.get(`[data-test="${SignUpSelectors.NEXT_BUTTON}"]`).click();

        const testPassword = 'AaBb$Cc123';
        const testShortPassword = 'aA1$';
        const testNoSmallPassword = 'A11111&A';
        const testNoCapitalPassword = 'a11111&a';
        const testNoNumberPassword = 'Aaaaaa&A';
        const testNoSpecialPassword = 'AaaaaabA';
        cy.get(`[data-test="${SignUpSelectors.PASSWORD_FIELD}"]`).type(
            testShortPassword
        );
        cy.document().contains(ValidationErrors.PASSWORD_LENGTH_ERROR);
        cy.get(`[data-test="${SignUpSelectors.PASSWORD_FIELD}"]`)
            .find('input')
            .clear();

        cy.get(`[data-test="${SignUpSelectors.PASSWORD_FIELD}"]`).type(
            testNoSmallPassword
        );
        cy.document().contains(ValidationErrors.PASSWORD_SMALL_LETTER_ERROR);
        cy.document()
            .contains(ValidationErrors.PASSWORD_LENGTH_ERROR)
            .should('have.length', 0);
        cy.get(`[data-test="${SignUpSelectors.PASSWORD_FIELD}"]`)
            .find('input')
            .clear();

        cy.get(`[data-test="${SignUpSelectors.PASSWORD_FIELD}"]`).type(
            testNoCapitalPassword
        );
        cy.document().contains(ValidationErrors.PASSWORD_CAPITAL_LETTER_ERROR);
        cy.document()
            .contains(ValidationErrors.PASSWORD_SMALL_LETTER_ERROR)
            .should('have.length', 0);
        cy.get(`[data-test="${SignUpSelectors.PASSWORD_FIELD}"]`)
            .find('input')
            .clear();

        cy.get(`[data-test="${SignUpSelectors.PASSWORD_FIELD}"]`).type(
            testNoNumberPassword
        );
        cy.document().contains(ValidationErrors.PASSWORD_NUMBER_ERROR);
        cy.document()
            .contains(ValidationErrors.PASSWORD_CAPITAL_LETTER_ERROR)
            .should('have.length', 0);
        cy.get(`[data-test="${SignUpSelectors.PASSWORD_FIELD}"]`)
            .find('input')
            .clear();

        cy.get(`[data-test="${SignUpSelectors.PASSWORD_FIELD}"]`).type(
            testNoSpecialPassword
        );
        cy.document().contains(
            ValidationErrors.PASSWORD_SPECIAL_CHARACTER_ERROR
        );
        cy.document()
            .contains(ValidationErrors.PASSWORD_NUMBER_ERROR)
            .should('have.length', 0);
        cy.get(`[data-test="${SignUpSelectors.PASSWORD_FIELD}"]`)
            .find('input')
            .clear();

        cy.get(`[data-test="${SignUpSelectors.PASSWORD_FIELD}"]`).type(
            testPassword
        );
        cy.document()
            .contains(ValidationErrors.PASSWORD_SPECIAL_CHARACTER_ERROR)
            .should('have.length', 0);

        cy.get(`[data-test="${SignUpSelectors.NEXT_BUTTON}"]`).click();

        cy.location('pathname').should('eq', '/home');
        cy.document().contains('For you');
    });
});
