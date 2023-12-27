import 'dart:math';

import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/main.dart' as app;
import 'package:tweaxy/shared/errors/sign_in_erros.dart';
import 'package:tweaxy/shared/errors/update_username_errors.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';
import 'package:tweaxy/shared/keys/profile_keys.dart';
import 'package:tweaxy/shared/keys/settings_keys.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/shared/keys/update_password_keys.dart';
import 'package:tweaxy/shared/keys/update_username_keys.dart';

import 'utils/registered_users.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Update Username Tests:', () {
    testWidgets('Update username successfully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var newUsername = users[0][2] + Random().nextInt(100).toString();
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

      var accountInfoButton =
          find.byKey(const ValueKey(SettingsKeys.accountInfo));
      await tester.tap(accountInfoButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var usernameButton =
          find.byKey(const ValueKey(SettingsKeys.usernameButton));
      await tester.tap(usernameButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var updateUsernameTextfield = find
          .byKey(const ValueKey(UpdateUsernameKeys.updateUsernameTextfield));
      await tester.enterText(updateUsernameTextfield, newUsername);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var updateUsernameButton =
          find.byKey(const ValueKey(UpdateUsernameKeys.updateUsernameButton));
      await tester.tap(updateUsernameButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("@$newUsername"), findsAny);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //Return the username to original username

      usernameButton = find.byKey(const ValueKey(SettingsKeys.usernameButton));
      await tester.tap(usernameButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      updateUsernameTextfield = find
          .byKey(const ValueKey(UpdateUsernameKeys.updateUsernameTextfield));
      await tester.enterText(updateUsernameTextfield, users[0][2]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      updateUsernameButton =
          find.byKey(const ValueKey(UpdateUsernameKeys.updateUsernameButton));
      await tester.tap(updateUsernameButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("@${users[0][2]}"), findsAny);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('Update username with wrong username format',
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

      var accountInfoButton =
          find.byKey(const ValueKey(SettingsKeys.accountInfo));
      await tester.tap(accountInfoButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var usernameButton =
          find.byKey(const ValueKey(SettingsKeys.usernameButton));
      await tester.tap(usernameButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //Username is short
      var updateUsernameTextfield = find
          .byKey(const ValueKey(UpdateUsernameKeys.updateUsernameTextfield));
      await tester.enterText(updateUsernameTextfield, "Lev");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var updateUsernameButton =
          find.byKey(const ValueKey(UpdateUsernameKeys.updateUsernameButton));
      await tester.tap(updateUsernameButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text(UpdateUsernameErrors.usernameMinLengthError), findsAny);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //Username contains spaces

      updateUsernameTextfield = find
          .byKey(const ValueKey(UpdateUsernameKeys.updateUsernameTextfield));
      await tester.enterText(updateUsernameTextfield, "Levi12 35");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      updateUsernameButton =
          find.byKey(const ValueKey(UpdateUsernameKeys.updateUsernameButton));
      await tester.tap(updateUsernameButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text(UpdateUsernameErrors.spaceError), findsAny);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('Update username with used username',
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

      var accountInfoButton =
          find.byKey(const ValueKey(SettingsKeys.accountInfo));
      await tester.tap(accountInfoButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var usernameButton =
          find.byKey(const ValueKey(SettingsKeys.usernameButton));
      await tester.tap(usernameButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var updateUsernameTextfield = find
          .byKey(const ValueKey(UpdateUsernameKeys.updateUsernameTextfield));
      await tester.enterText(updateUsernameTextfield, users[3][2]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var updateUsernameButton =
          find.byKey(const ValueKey(UpdateUsernameKeys.updateUsernameButton));
      await tester.tap(updateUsernameButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text(UpdateUsernameErrors.uniquenessError), findsAny);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });
  });
}
