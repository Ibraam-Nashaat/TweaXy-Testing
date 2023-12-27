import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/main.dart' as app;
import 'package:tweaxy/shared/errors/sign_in_erros.dart';
import 'package:tweaxy/shared/keys/delete_tweet_keys.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';
import 'package:tweaxy/shared/keys/mute_user_keys.dart';
import 'package:tweaxy/shared/keys/profile_keys.dart';
import 'package:tweaxy/shared/keys/settings_keys.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/shared/keys/update_password_keys.dart';
import 'package:tweaxy/shared/utils.dart';

import 'utils/registered_users.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  var tweetContent = "mute test";
  group('Mute/Unmute user tests:', () {
    // testWidgets('Mute user', (WidgetTester tester) async {
    //   app.main();
    //   await tester.pumpAndSettle(const Duration(seconds: 2));

    //   var logInButton =
    //       find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
    //   await tester.tap(logInButton);
    //   await tester.pumpAndSettle();

    //   var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
    //   await tester.enterText(emailTextField, users[0][0]);
    //   await tester.pumpAndSettle(const Duration(seconds: 1));

    //   var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
    //   await tester.pumpAndSettle(const Duration(seconds: 1));
    //   await tester.ensureVisible(nextButton);
    //   await tester.tap(nextButton);
    //   await tester.pumpAndSettle(const Duration(seconds: 3));

    //   var passwordTextField =
    //       find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
    //   await tester.enterText(passwordTextField, users[0][1]);
    //   await tester.pumpAndSettle(const Duration(seconds: 1));

    //   nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
    //   await tester.pumpAndSettle(const Duration(seconds: 1));
    //   await tester.ensureVisible(nextButton);
    //   await tester.tap(nextButton);
    //   await tester.pumpAndSettle(const Duration(seconds: 3));

    //   var utils = Utils();
    //   var hash = utils.hashText(DeleteTweetKeys.tweetSettingsClickMobile +
    //       tweetContent +
    //       users[3][2]);
    //   var tweetSettings = find.byKey(ValueKey(hash));
    //   await tester.pumpAndSettle(const Duration(seconds: 1));
    //   await tester.tap(tweetSettings);
    //   await tester.pumpAndSettle(const Duration(seconds: 3));

    //   var muteUserButton = find.byKey(const ValueKey(MuteUserKeys.muteUser));
    //   await tester.pumpAndSettle(const Duration(seconds: 1));
    //   await tester.tap(muteUserButton);
    //   await tester.pumpAndSettle(const Duration(seconds: 3));

    //   expect(find.text(tweetContent), findsNothing);
    //   await tester.pumpAndSettle(const Duration(seconds: 3));

    //   var homeScreenProfileButton =
    //       find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
    //   await tester.tap(homeScreenProfileButton);
    //   await tester.pumpAndSettle(const Duration(seconds: 1));

    //   var settingsAndPrivacyButton =
    //       find.byKey(const ValueKey(HomePageKeys.settingsAndPrivacy));
    //   await tester.tap(settingsAndPrivacyButton);
    //   await tester.pumpAndSettle(const Duration(seconds: 1));

    //   var privacyAndSafety =
    //       find.byKey(const ValueKey(SettingsKeys.privacyAndSafety));
    //   await tester.tap(privacyAndSafety);
    //   await tester.pumpAndSettle(const Duration(seconds: 1));

    //   var muteAndBlock = find.byKey(const ValueKey(SettingsKeys.muteAndBlock));
    //   await tester.tap(muteAndBlock);
    //   await tester.pumpAndSettle(const Duration(seconds: 1));

    //   var mutedAccounts =
    //       find.byKey(const ValueKey(SettingsKeys.mutedAccounts));
    //   await tester.tap(mutedAccounts);
    //   await tester.pumpAndSettle(const Duration(seconds: 3));
    //   expect(find.text(users[3][2]), findsOneWidget);
    // });

    testWidgets('UnMute user', (WidgetTester tester) async {
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

      var privacyAndSafety =
          find.byKey(const ValueKey(SettingsKeys.privacyAndSafety));
      await tester.tap(privacyAndSafety);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var muteAndBlock = find.byKey(const ValueKey(SettingsKeys.muteAndBlock));
      await tester.tap(muteAndBlock);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var mutedAccounts =
          find.byKey(const ValueKey(SettingsKeys.mutedAccounts));
      await tester.tap(mutedAccounts);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var unmuteButton = find.byKey(const ValueKey(MuteUserKeys.unmuteUser));
      await tester.tap(unmuteButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text(users[3][2]), findsNothing);
    });
  });
}
