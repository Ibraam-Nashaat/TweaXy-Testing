import SignInSelectors from "../../src/shared/selectors/SignIn.js";
import MainPageSelectors from "../../src/shared/selectors/MainPage.js";
import TestUser from "../TestUser.js";
import SignInErrors from "../../src/shared/errors/SignInErrors.js";
describe("Sign In Tests", () => {
  it("Sign in successfully", () => {
    cy.visit(`/`);
    cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
    cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
      `${TestUser[0].EMAIL}`
    );
    cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
    cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
      `${TestUser[0].PASSWORD}`
    );
    cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
    cy.location("pathname").should("eq", "/home");
    cy.document().contains("For you");
  });

  it("Sign in with unregistered email", () => {
    cy.visit(`/`);
    cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
    cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
      "ahmed@gmail.com"
    );
    cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
    cy.location("pathname").should("eq", "/");
    cy.document().contains(`${SignInErrors.UNREGISTERED_EMAIL}`);
  });

  it("Sign in with wrong password", () => {
    cy.visit(`/`);
    cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
    cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
      `${TestUser[0].EMAIL}`
    );
    cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
    cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
      "Ahmed@123456"
    );
    cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
    cy.location("pathname").should("eq", "/");
    cy.document().contains(`${SignInErrors.WRONG_PASSWORD}`);
  });
});
