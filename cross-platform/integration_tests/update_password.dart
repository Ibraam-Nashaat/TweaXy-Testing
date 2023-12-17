import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/main.dart' as app;
import 'package:tweaxy/shared/errors/sign_in_erros.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';
import 'package:tweaxy/shared/keys/profile_keys.dart';
import 'package:tweaxy/shared/keys/settings_keys.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/shared/keys/update_password_keys.dart';

import 'utils/registered_users.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Update Password Tests:', () {
    testWidgets(
        'Change password with unmatching new password and confirmation new password',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[0][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[0][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var settingsAndPrivacyButton =
          find.byKey(const ValueKey(HomePageKeys.settingsAndPrivacy));
      await tester.tap(settingsAndPrivacyButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var yourAccountButton =
          find.byKey(const ValueKey(SettingsKeys.yourAccount));
      await tester.tap(yourAccountButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var changePasswordButton =
          find.byKey(const ValueKey(SettingsKeys.changePassword));
      await tester.tap(changePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var oldPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.oldPassword));
      await tester.enterText(oldPassword, users[0][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var newPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.newPassword));
      await tester.enterText(newPassword, users[0][4]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var confirmNewPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.confirmPassword));
      await tester.enterText(confirmNewPassword, "Ahmed@1234");
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var updatePasswordButton =
          find.byKey(const ValueKey(UpdatePasswordKeys.updatePasswordButton));
      await tester.tap(updatePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("Update Password"), findsOneWidget);
    });

    testWidgets('Change password with new password as current password',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[0][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[0][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var settingsAndPrivacyButton =
          find.byKey(const ValueKey(HomePageKeys.settingsAndPrivacy));
      await tester.tap(settingsAndPrivacyButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var yourAccountButton =
          find.byKey(const ValueKey(SettingsKeys.yourAccount));
      await tester.tap(yourAccountButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var changePasswordButton =
          find.byKey(const ValueKey(SettingsKeys.changePassword));
      await tester.tap(changePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var oldPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.oldPassword));
      await tester.enterText(oldPassword, users[0][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var newPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.newPassword));
      await tester.enterText(newPassword, users[0][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var confirmNewPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.confirmPassword));
      await tester.enterText(confirmNewPassword, users[0][1]);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var updatePasswordButton =
          find.byKey(const ValueKey(UpdatePasswordKeys.updatePasswordButton));
      await tester.tap(updatePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("Update Password"), findsOneWidget);
    });

    testWidgets('Change password with wrong current password',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[0][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[0][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var settingsAndPrivacyButton =
          find.byKey(const ValueKey(HomePageKeys.settingsAndPrivacy));
      await tester.tap(settingsAndPrivacyButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var yourAccountButton =
          find.byKey(const ValueKey(SettingsKeys.yourAccount));
      await tester.tap(yourAccountButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var changePasswordButton =
          find.byKey(const ValueKey(SettingsKeys.changePassword));
      await tester.tap(changePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var oldPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.oldPassword));
      await tester.enterText(oldPassword, "Ahmed@1234");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var newPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.newPassword));
      await tester.enterText(newPassword, users[0][4]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var confirmNewPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.confirmPassword));
      await tester.enterText(confirmNewPassword, users[0][4]);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var updatePasswordButton =
          find.byKey(const ValueKey(UpdatePasswordKeys.updatePasswordButton));
      await tester.tap(updatePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("Update Password"), findsOneWidget);
    });

    testWidgets(
        'Change password with new password having different validation errors',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[0][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[0][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var settingsAndPrivacyButton =
          find.byKey(const ValueKey(HomePageKeys.settingsAndPrivacy));
      await tester.tap(settingsAndPrivacyButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var yourAccountButton =
          find.byKey(const ValueKey(SettingsKeys.yourAccount));
      await tester.tap(yourAccountButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var changePasswordButton =
          find.byKey(const ValueKey(SettingsKeys.changePassword));
      await tester.tap(changePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var oldPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.oldPassword));
      await tester.enterText(oldPassword, users[0][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //Password length error
      var newPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.newPassword));
      await tester.enterText(newPassword, "Kalawy");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var confirmNewPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.confirmPassword));
      await tester.enterText(confirmNewPassword, "Kalawy");
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var updatePasswordButton =
          find.byKey(const ValueKey(UpdatePasswordKeys.updatePasswordButton));
      await tester.tap(updatePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("Update Password"), findsOneWidget);

      //Password missing special character error
      newPassword = find.byKey(const ValueKey(UpdatePasswordKeys.newPassword));
      await tester.enterText(newPassword, "Kalawy12");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      confirmNewPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.confirmPassword));
      await tester.enterText(confirmNewPassword, "Kalawy12");
      await tester.pumpAndSettle(const Duration(seconds: 2));

      updatePasswordButton =
          find.byKey(const ValueKey(UpdatePasswordKeys.updatePasswordButton));
      await tester.tap(updatePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("Update Password"), findsOneWidget);

      //Password missing capital character error
      newPassword = find.byKey(const ValueKey(UpdatePasswordKeys.newPassword));
      await tester.enterText(newPassword, "kalawy@1234");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      confirmNewPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.confirmPassword));
      await tester.enterText(confirmNewPassword, "kalawy@1234");
      await tester.pumpAndSettle(const Duration(seconds: 2));

      updatePasswordButton =
          find.byKey(const ValueKey(UpdatePasswordKeys.updatePasswordButton));
      await tester.tap(updatePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("Update Password"), findsOneWidget);

      //Password missing number error
      newPassword = find.byKey(const ValueKey(UpdatePasswordKeys.newPassword));
      await tester.enterText(newPassword, "Kalawy@K");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      confirmNewPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.confirmPassword));
      await tester.enterText(confirmNewPassword, "Kalawy@K");
      await tester.pumpAndSettle(const Duration(seconds: 2));

      updatePasswordButton =
          find.byKey(const ValueKey(UpdatePasswordKeys.updatePasswordButton));
      await tester.tap(updatePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("Update Password"), findsOneWidget);

      //Password missing small letter error
      newPassword = find.byKey(const ValueKey(UpdatePasswordKeys.newPassword));
      await tester.enterText(newPassword, "KALAWY@1234");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      confirmNewPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.confirmPassword));
      await tester.enterText(confirmNewPassword, "KALAWY@1234");
      await tester.pumpAndSettle(const Duration(seconds: 2));

      updatePasswordButton =
          find.byKey(const ValueKey(UpdatePasswordKeys.updatePasswordButton));
      await tester.tap(updatePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("Update Password"), findsOneWidget);
    });

    testWidgets('Change password successfully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[0][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[0][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var settingsAndPrivacyButton =
          find.byKey(const ValueKey(HomePageKeys.settingsAndPrivacy));
      await tester.tap(settingsAndPrivacyButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var yourAccountButton =
          find.byKey(const ValueKey(SettingsKeys.yourAccount));
      await tester.tap(yourAccountButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var changePasswordButton =
          find.byKey(const ValueKey(SettingsKeys.changePassword));
      await tester.tap(changePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var oldPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.oldPassword));
      await tester.enterText(oldPassword, users[0][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var newPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.newPassword));
      await tester.enterText(newPassword, users[0][4]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var confirmNewPassword =
          find.byKey(const ValueKey(UpdatePasswordKeys.confirmPassword));
      await tester.enterText(confirmNewPassword, users[0][4]);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var updatePasswordButton =
          find.byKey(const ValueKey(UpdatePasswordKeys.updatePasswordButton));
      await tester.tap(updatePasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text("Update Password"), findsNothing);

    });

     testWidgets('Sign in successfully with new password',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[0][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[0][4]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("Following"), findsOneWidget);
    });
  });
}
