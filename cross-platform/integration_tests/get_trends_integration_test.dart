import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/main.dart' as app;

import 'utils/registered_users.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Get Trends Tests', () {
    testWidgets('Find Trends Page with non empty trends',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();
      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[0][0]);
      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[0][1]);
      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var searchButton = find.byKey(const ValueKey(HomePageKeys.navSearchIcon));
      await tester.tap(searchButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final trendingsList =
          find.byKey(const ValueKey(HomePageKeys.trendingList));
      expect(trendingsList, findsOneWidget);

      final trendingItems =
          find.byKey(const ValueKey(HomePageKeys.trendingItem));
      final trendingItemsCount = tester.widgetList(trendingItems).length;
      expect(trendingItemsCount, isNot(equals(0)));
    });
    testWidgets('Find Trends Page with non empty trends posts',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();
      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField,
          'c54d7994-b997-47ee-8bdd-f8c1525e6102@email.webhook.site');
      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, 'aAbBcC\$123');
      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var searchButton = find.byKey(const ValueKey(HomePageKeys.navSearchIcon));
      await tester.tap(searchButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final trendingsList =
          find.byKey(const ValueKey(HomePageKeys.trendingList));
      expect(trendingsList, findsOneWidget);

      final trendingItems =
          find.byKey(const ValueKey(HomePageKeys.trendingItem));

      for (final item in tester.widgetList(trendingItems)) {
        final text = item.toString()[0];
        expect(text, isNot('0'));
      }
    });
  });
}
