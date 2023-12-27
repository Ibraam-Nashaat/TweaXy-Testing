import SignInSelectors from '../../src/shared/selectors/SignIn.js';
import MainPageSelectors from '../../src/shared/selectors/MainPage.js';
import TestUser from '../TestUser.js';
import HomePageSelectors from '../../src/shared/selectors/HomePage.js';
import ProfilePageSelectors from '../../src/shared/selectors/ProfilePage.js';

describe('Edit Profile:', () => {
    it('Edit profile successfully', () => {
        const newName = "HamadaX";
        const newBio = "Faculty of Engineering, Cairo University";
        const newLocation = "Cairo";
        const newWebsite = "hamadax.com";
        //Sign in
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[0].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.get(
            `[data-test="${ProfilePageSelectors.EDIT_PROFILE_BUTTON}"]`
        ).click();

        //Clear all fields
        cy.get(`[data-test="${ProfilePageSelectors.NAME_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.BIO_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.LOCATION_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            '{selectall}{backspace}'
        );

        //Type new data
        cy.get(`[data-test="${ProfilePageSelectors.NAME_FIELD}"]`).type(
            newName
        );
        cy.get(`[data-test="${ProfilePageSelectors.BIO_FIELD}"]`).type(newBio);
        cy.get(`[data-test="${ProfilePageSelectors.LOCATION_FIELD}"]`).type(
            newLocation
        );
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            `http://${newWebsite}`
        );
        cy.get(`[data-test="${ProfilePageSelectors.SAVE_BUTTON}"]`).click();
        cy.reload();

        cy.document().contains(newName);
        cy.document().contains(newBio);
        cy.document().contains(newLocation);
        cy.document().contains(newWebsite);
        cy.wait(3000);
    });

    it('Edit name only successfully', () => {
        const newName = "Hamada El King";
        //Sign in
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[0].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.get(
            `[data-test="${ProfilePageSelectors.EDIT_PROFILE_BUTTON}"]`
        ).click();

        //Clear all fields
        cy.get(`[data-test="${ProfilePageSelectors.NAME_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.BIO_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.LOCATION_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            '{selectall}{backspace}'
        );

        //Type new data
        cy.get(`[data-test="${ProfilePageSelectors.NAME_FIELD}"]`).type(
            newName
        );
        cy.get(`[data-test="${ProfilePageSelectors.SAVE_BUTTON}"]`).click();
        cy.reload();

        cy.document().contains(newName);
        cy.wait(3000);
    });

    it('Edit location only successfully', () => {
        const newLocation = "Hurghada";
        //Sign in
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[0].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.get(
            `[data-test="${ProfilePageSelectors.EDIT_PROFILE_BUTTON}"]`
        ).click();

        //Clear all fields
        cy.get(`[data-test="${ProfilePageSelectors.BIO_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.LOCATION_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            '{selectall}{backspace}'
        );

        //Type new data
        cy.get(`[data-test="${ProfilePageSelectors.LOCATION_FIELD}"]`).type(
            newLocation
        );
        cy.get(`[data-test="${ProfilePageSelectors.SAVE_BUTTON}"]`).click();
        cy.reload();

        cy.document().contains(newLocation);
        cy.wait(3000);
    });

    it('Edit bio only successfully', () => {
        const newBio = "Half Egyptian, Half Italian";
        //Sign in
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[0].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.get(
            `[data-test="${ProfilePageSelectors.EDIT_PROFILE_BUTTON}"]`
        ).click();

        //Clear all fields
        cy.get(`[data-test="${ProfilePageSelectors.BIO_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.LOCATION_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            '{selectall}{backspace}'
        );

        //Type new data
        cy.get(`[data-test="${ProfilePageSelectors.BIO_FIELD}"]`).type(
            newBio
        );
        cy.get(`[data-test="${ProfilePageSelectors.SAVE_BUTTON}"]`).click();
        cy.reload();

        cy.document().contains(newBio);
        cy.wait(3000);
    });

    it('Edit website only successfully', () => {
        const newWebsite = "hamada123465.com";
        //Sign in
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[0].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.get(
            `[data-test="${ProfilePageSelectors.EDIT_PROFILE_BUTTON}"]`
        ).click();

        //Clear all fields
        cy.get(`[data-test="${ProfilePageSelectors.BIO_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.LOCATION_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            '{selectall}{backspace}'
        );

        //Type new data
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            `http://${newWebsite}`
        );
        cy.get(`[data-test="${ProfilePageSelectors.SAVE_BUTTON}"]`).click();
        cy.reload();

        cy.document().contains(newWebsite);
        cy.wait(3000);
    });

    it('Edit website only with wrong website format', () => {
        //Sign in
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[0].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.get(
            `[data-test="${ProfilePageSelectors.EDIT_PROFILE_BUTTON}"]`
        ).click();

        //Clear all fields
        cy.get(`[data-test="${ProfilePageSelectors.BIO_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.LOCATION_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            '{selectall}{backspace}'
        );

        //Type new data
        //First wrong website format
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            `hamada`
        );
        cy.get(`[data-test="${ProfilePageSelectors.SAVE_BUTTON}"]`).click();
        cy.document().contains("Bio");

        //Second wrong website format
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            `http://hamada`
        );
        cy.get(`[data-test="${ProfilePageSelectors.SAVE_BUTTON}"]`).click();
        cy.document().contains("Bio");
        cy.wait(3000);
    });

    it('Edit name field with empty name', () => {
        //Sign in
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[0].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.get(
            `[data-test="${ProfilePageSelectors.EDIT_PROFILE_BUTTON}"]`
        ).click();

        //Clear all fields
        cy.get(`[data-test="${ProfilePageSelectors.NAME_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.BIO_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.LOCATION_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            '{selectall}{backspace}'
        );


        cy.get(`[data-test="${ProfilePageSelectors.SAVE_BUTTON}"]`).click();

        cy.document().contains("Bio");
        cy.wait(3000);
    });


    it('Edit name field with spaces', () => {
        //Sign in
        cy.visit(`/`);
        cy.get(`[data-test="${MainPageSelectors.SIGN_IN}"]`).click();
        cy.get(`[data-test="${SignInSelectors.EMAIL_FIELD}"]`).type(
            `${TestUser[0].EMAIL}`
        );
        cy.wait(1000);
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();
        cy.get(`[data-test="${SignInSelectors.PASSWORD_FIELD}"]`).type(
            `${TestUser[0].PASSWORD}`
        );
        cy.get(`[data-test="${SignInSelectors.NEXT_BUTTON}"]`).click();

        cy.get(`[data-test="${HomePageSelectors.PROFILE_BUTTON}"]`).click();
        cy.get(
            `[data-test="${ProfilePageSelectors.EDIT_PROFILE_BUTTON}"]`
        ).click();

        //Clear all fields
        cy.get(`[data-test="${ProfilePageSelectors.NAME_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.BIO_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.LOCATION_FIELD}"]`).type(
            '{selectall}{backspace}'
        );
        cy.get(`[data-test="${ProfilePageSelectors.WEBSITE_FIELD}"]`).type(
            '{selectall}{backspace}'
        );

        cy.get(`[data-test="${ProfilePageSelectors.NAME_FIELD}"]`).type(
            `        `
        );
        cy.get(`[data-test="${ProfilePageSelectors.SAVE_BUTTON}"]`).click();

        cy.document().contains("Bio");
        cy.wait(3000);
        
    });
});
