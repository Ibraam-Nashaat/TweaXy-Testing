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
  group('Add, View, and Remove Block', () {
    testWidgets('Add Block', (WidgetTester tester) async {
      // Sign in
      app.main();
      await tester.pumpAndSettle();

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

      var searchButton = find.byKey(const ValueKey(HomePageKeys.navSearchIcon));
      await tester.tap(searchButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final searchBar = find.byKey(const Key(SearchKeys.searchField));
      await tester.enterText(searchBar, users[1][0]);
      await tester.pumpAndSettle();

      final userSearchItem = find.byKey(const Key(users[1][0]+'-'+SearchKeys.userSearchItem));
      await tester.tap(userSearchItem);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final moreOptionsButton = find.byKey(const Key(ProfileKeys.moreOptionsButton));
      await tester.tap(moreOptionsButton);
      await tester.pumpAndSettle();

      final blockUserButton = find.byKey(const Key(ProfileKeys.blockUserButton));
      await tester.tap(blockUserButton);
      await tester.pumpAndSettle();

      final blockUserConfirmButton = find.byKey(const Key(ProfileKeys.blockUserConfirmButton));
      await tester.tap(blockUserConfirmButton);
      await tester.pumpAndSettle();

      await tester.pump(Duration(seconds: 5));

      final profileBackButton = find.byKey(const Key(ProfileKeys.backButton));
      await tester.tap(profileBackButton);
      await tester.pumpAndSettle();
    });
    testWidgets('Check Block', (WidgetTester tester) async {
      // Sign in
      app.main();
      await tester.pumpAndSettle();

      var logInButton =
            find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[1][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[1][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var searchButton = find.byKey(const ValueKey(HomePageKeys.navSearchIcon));
      await tester.tap(searchButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final searchBar = find.byKey(const Key(SearchKeys.searchField));
      await tester.enterText(searchBar, users[0][0]);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key(users[0][0]+'-'+SearchKeys.userSearchItem)), findsNothing);
    });
    testWidgets('Remove block', (WidgetTester tester) async {
      // Sign in
      app.main();
      await tester.pumpAndSettle();

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

      var privacyAndSafetyButton =
          find.byKey(const ValueKey(SettingsKeys.privacyAndSafetyKey));
      await tester.tap(privacyAndSafetyButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var muteAndBlockButton =
          find.byKey(const ValueKey(SettingsKeys.muteAndBlockKey));
      await tester.tap(muteAndBlockButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var blockedAccountsButton =
          find.byKey(const ValueKey(SettingsKeys.blockedAccountsKey));
      await tester.tap(blockedAccountsButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // There is only one blocked user (For testing purposes)
      var unblockUserButton =
          find.byKey(const ValueKey(SettingsKeys.unblockUserButtonKey));
      await tester.tap(unblockUserButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });
    testWidgets('Check UnBlock', (WidgetTester tester) async {
      // Sign in
      app.main();
      await tester.pumpAndSettle();

      var logInButton =
            find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[1][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[1][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var searchButton = find.byKey(const ValueKey(HomePageKeys.navSearchIcon));
      await tester.tap(searchButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final searchBar = find.byKey(const Key(SearchKeys.searchField));
      await tester.enterText(searchBar, users[0][0]);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key(users[0][0]+'-'+SearchKeys.userSearchItem)), findsOneWidget);
    });
  });
};