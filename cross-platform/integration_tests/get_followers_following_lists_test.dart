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
    group('Get Followers and Following Lists', () {   
        testWidgets('Get Followers List', (WidgetTester tester) async {
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

            final followersButton = find.byKey(const Key(ProfileKeys.followersButton));
            await tester.tap(followersButton);
            await tester.pumpAndSettle(const Duration(seconds: 3));
        });
        testWidgets('Get Following List', (WidgetTester tester) async {
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

            final followingButton = find.byKey(const Key(ProfileKeys.followingButton));
            await tester.tap(followingButton);
            await tester.pumpAndSettle(const Duration(seconds: 3));
        });
    });
}

