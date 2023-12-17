import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/main.dart' as app;
import 'package:tweaxy/shared/errors/sign_in_erros.dart';
import 'package:tweaxy/shared/keys/add_tweet_keys.dart';
import 'package:tweaxy/shared/keys/delete_tweet_keys.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';
import 'package:tweaxy/shared/keys/profile_keys.dart';
import 'package:tweaxy/shared/keys/search_keys.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/shared/utils.dart';
import 'dart:math';
import 'utils/registered_users.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  var tweetContent =
      "This is a tweet for search tweet ${Random().nextInt(10000000)}";

  group('Search Tweets Tests:', () {
    testWidgets('Search for a tweet posted by the same user successfully ',
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

      // Search for that tweet
      var searchIcon = find.byKey(const ValueKey(HomePageKeys.navSearchIcon));
      await tester.tap(searchIcon);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var searchBar = find.byKey(const ValueKey(SearchKeys.searchBar));
      await tester.tap(searchBar);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var searchField = find.byKey(const ValueKey(SearchKeys.searchField));
      await tester.enterText(searchField, tweetContent);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text(tweetContent), findsAny);
      expect(find.text(users[0][3]), findsAny);
    });

    testWidgets('Search for a tweet posted by the different user successfully ',
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

      // Search for the tweet
      var searchIcon = find.byKey(const ValueKey(HomePageKeys.navSearchIcon));
      await tester.tap(searchIcon);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var searchBar = find.byKey(const ValueKey(SearchKeys.searchBar));
      await tester.tap(searchBar);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var searchField = find.byKey(const ValueKey(SearchKeys.searchField));
      await tester.enterText(searchField, tweetContent);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text(tweetContent), findsAny);
      expect(find.text(users[0][3]), findsAny);
    });
  });
}
