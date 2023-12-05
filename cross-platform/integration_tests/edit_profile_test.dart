import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/main.dart' as app;
import 'package:tweaxy/shared/errors/sign_in_erros.dart';
import 'package:tweaxy/shared/keys/profile_keys.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';

import 'utils/registered_users.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Edit Profile:', () {
    testWidgets('Edit all profile fields successfully',
        (WidgetTester tester) async {
      const newName = "HamadaX";
      const newBio = "Faculty of Engineering, Cairo University";
      const newLocation = "Cairo";
      const newWebsite = "hamadax.com";
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[2][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[2][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var editProfileButton =
          find.byKey(const ValueKey(ProfileKeys.editProfileButton));
      await tester.tap(editProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nameTextfield = find.byKey(const ValueKey(ProfileKeys.nameTextfield));
      await tester.enterText(nameTextfield, " ");
      await tester.enterText(nameTextfield, newName);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var bioTextfield = find.byKey(const ValueKey(ProfileKeys.bioTextfield));
      await tester.enterText(bioTextfield, " ");
      await tester.enterText(bioTextfield, newBio);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var locationTextfield =
          find.byKey(const ValueKey(ProfileKeys.locationTextfield));
      await tester.enterText(locationTextfield, " ");
      await tester.enterText(locationTextfield, newLocation);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var websiteTextfield =
          find.byKey(const ValueKey(ProfileKeys.websiteTextfield));
      await tester.enterText(websiteTextfield, " ");
      await tester.enterText(websiteTextfield, "http://$newWebsite");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var saveButton = find.byKey(const ValueKey(ProfileKeys.saveButton));
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text(newName), findsOneWidget);
      expect(find.text(newBio), findsOneWidget);
      expect(find.text(newLocation), findsOneWidget);
      expect(find.text(newWebsite), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('Edit name only successfully', (WidgetTester tester) async {
      const newName = "Hamada El King";
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[2][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[2][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var editProfileButton =
          find.byKey(const ValueKey(ProfileKeys.editProfileButton));
      await tester.tap(editProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nameTextfield = find.byKey(const ValueKey(ProfileKeys.nameTextfield));
      await tester.enterText(nameTextfield, " ");
      await tester.enterText(nameTextfield, newName);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var bioTextfield = find.byKey(const ValueKey(ProfileKeys.bioTextfield));
      await tester.enterText(bioTextfield, "");
      await tester.enterText(bioTextfield, "");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var locationTextfield =
          find.byKey(const ValueKey(ProfileKeys.locationTextfield));
      await tester.enterText(locationTextfield, "");
      await tester.enterText(locationTextfield, "");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var websiteTextfield =
          find.byKey(const ValueKey(ProfileKeys.websiteTextfield));
      await tester.enterText(websiteTextfield, "");
      await tester.enterText(websiteTextfield, "");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var saveButton = find.byKey(const ValueKey(ProfileKeys.saveButton));
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text(newName), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('Edit location only successfully', (WidgetTester tester) async {
      const newLocation = "Hurghada";
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[2][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[2][1]);

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var editProfileButton =
          find.byKey(const ValueKey(ProfileKeys.editProfileButton));
      await tester.tap(editProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var bioTextfield = find.byKey(const ValueKey(ProfileKeys.bioTextfield));
      await tester.enterText(bioTextfield, "");
      await tester.enterText(bioTextfield, "");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var locationTextfield =
          find.byKey(const ValueKey(ProfileKeys.locationTextfield));
      await tester.enterText(locationTextfield, " ");
      await tester.enterText(locationTextfield, newLocation);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var websiteTextfield =
          find.byKey(const ValueKey(ProfileKeys.websiteTextfield));
      await tester.enterText(websiteTextfield, "");
      await tester.enterText(websiteTextfield, "");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var saveButton = find.byKey(const ValueKey(ProfileKeys.saveButton));
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text(newLocation), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('Edit bio only successfully', (WidgetTester tester) async {
      const newBio = "Half Egyptian, Half Italian";
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[2][0]);

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[2][1]);

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var editProfileButton =
          find.byKey(const ValueKey(ProfileKeys.editProfileButton));
      await tester.tap(editProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var bioTextfield = find.byKey(const ValueKey(ProfileKeys.bioTextfield));
      await tester.enterText(bioTextfield, " ");
      await tester.enterText(bioTextfield, newBio);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var locationTextfield =
          find.byKey(const ValueKey(ProfileKeys.locationTextfield));
      await tester.enterText(locationTextfield, "");
      await tester.enterText(locationTextfield, "");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var websiteTextfield =
          find.byKey(const ValueKey(ProfileKeys.websiteTextfield));
      await tester.enterText(websiteTextfield, "");
      await tester.enterText(websiteTextfield, "");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var saveButton = find.byKey(const ValueKey(ProfileKeys.saveButton));
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text(newBio), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('Edit website only successfully', (WidgetTester tester) async {
      const newWebsite = "hamada123465.com";
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[2][0]);

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[2][1]);

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var editProfileButton =
          find.byKey(const ValueKey(ProfileKeys.editProfileButton));
      await tester.tap(editProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var bioTextfield = find.byKey(const ValueKey(ProfileKeys.bioTextfield));
      await tester.enterText(bioTextfield, "");
      await tester.enterText(bioTextfield, "");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var locationTextfield =
          find.byKey(const ValueKey(ProfileKeys.locationTextfield));
      await tester.enterText(locationTextfield, "");
      await tester.enterText(locationTextfield, "");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var websiteTextfield =
          find.byKey(const ValueKey(ProfileKeys.websiteTextfield));
      await tester.enterText(websiteTextfield, " ");
      await tester.enterText(websiteTextfield, "http://$newWebsite");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var saveButton = find.byKey(const ValueKey(ProfileKeys.saveButton));
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text(newWebsite), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('Edit website only with wrong website format',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[2][0]);

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[2][1]);

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var editProfileButton =
          find.byKey(const ValueKey(ProfileKeys.editProfileButton));
      await tester.tap(editProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var bioTextfield = find.byKey(const ValueKey(ProfileKeys.bioTextfield));
      await tester.enterText(bioTextfield, "");
      await tester.enterText(bioTextfield, "");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var locationTextfield =
          find.byKey(const ValueKey(ProfileKeys.locationTextfield));
      await tester.enterText(locationTextfield, "");
      await tester.enterText(locationTextfield, "");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //first wrong website format
      var websiteTextfield =
          find.byKey(const ValueKey(ProfileKeys.websiteTextfield));
      await tester.enterText(websiteTextfield, " ");
      await tester.enterText(websiteTextfield, "hamada");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var saveButton = find.byKey(const ValueKey(ProfileKeys.saveButton));
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("Bio"), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      //Second wrong website format
      websiteTextfield =
          find.byKey(const ValueKey(ProfileKeys.websiteTextfield));
      await tester.enterText(websiteTextfield, " ");
      await tester.enterText(websiteTextfield, "http://hamada");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      saveButton = find.byKey(const ValueKey(ProfileKeys.saveButton));
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("Bio"), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('Edit name field with empty name', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[2][0]);

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[2][1]);

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var editProfileButton =
          find.byKey(const ValueKey(ProfileKeys.editProfileButton));
      await tester.tap(editProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nameTextfield = find.byKey(const ValueKey(ProfileKeys.nameTextfield));
      await tester.enterText(nameTextfield, "");
      await tester.enterText(nameTextfield, "");
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var saveButton = find.byKey(const ValueKey(ProfileKeys.saveButton));
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text("Bio"), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });

    testWidgets('Edit name field with spaces', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[2][0]);

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[2][1]);

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var editProfileButton =
          find.byKey(const ValueKey(ProfileKeys.editProfileButton));
      await tester.tap(editProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nameTextfield = find.byKey(const ValueKey(ProfileKeys.nameTextfield));
      await tester.enterText(nameTextfield, "   ");
      await tester.enterText(nameTextfield, "   ");
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var saveButton = find.byKey(const ValueKey(ProfileKeys.saveButton));
      await tester.tap(saveButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text("Bio"), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });
}
