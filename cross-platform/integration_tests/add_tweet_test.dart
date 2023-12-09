import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/main.dart' as app;
import 'package:tweaxy/shared/errors/sign_in_erros.dart';
import 'package:tweaxy/shared/keys/add_tweet_keys.dart';
import 'package:tweaxy/shared/keys/profile_keys.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'dart:math';
import 'utils/registered_users.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  var tweetContent = Random().nextInt(10000000).toString();

  group('Add Tweets tests:', () {
    testWidgets('Add tweet successfully to an account',
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

      var floatingAddTweetButton =
          find.byKey(const ValueKey(AddTweetKeys.addTweet));
      await tester.tap(floatingAddTweetButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var addTweetButton =
          find.byKey(const ValueKey(AddTweetKeys.addNormalTweet));
      await tester.tap(addTweetButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var tweetTextField =
          find.byKey(const ValueKey(AddTweetKeys.tweetTextField));
      await tester.enterText(tweetTextField, tweetContent);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var postTweetButton = find.byKey(const ValueKey(AddTweetKeys.postTweet));
      await tester.tap(postTweetButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text(tweetContent), findsOneWidget);

      var homeScreenProfileButton =
          find.byKey(const ValueKey(ProfileKeys.homeScreenProfileButton));
      await tester.tap(homeScreenProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text(tweetContent), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('Check that previously added tweet reflect on followers feed',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[3][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[3][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text(tweetContent), findsOneWidget);
      expect(find.text(users[0][2]), findsAny);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });
  });
}
