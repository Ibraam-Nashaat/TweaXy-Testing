import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tweaxy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:tweaxy/shared/keys/sign_up_keys.dart';
import './utils/WebHookUtils.dart';
import 'package:tweaxy/views/homepage.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  String getMonthName(int month) {
    List<String> monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }

  String formatDay(int day) {
    // Using String interpolation to format the day with two digits
    return day < 10 ? '0$day' : '$day';
  }

  group('end-to-end test', () {
    testWidgets('SignUp with right inputs', (tester) async {
      // Load app widget.
      await tester.pumpWidget(const TweaXy());
      // Splash Screen
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final signUpPageButton = find.byKey(const ValueKey("signupStartScreen"));
      // Click on signUp button
      await tester.tap(signUpPageButton);

      // Go to signUp page
      await tester.pumpAndSettle();

      final fieldsFinder =
          find.byKey(const ValueKey(SignUpKeys.createAccountFieldsKey));

      // Verify that signUp fields exist
      expect(fieldsFinder, findsOneWidget);

      // Get SignUp first page fields
      final nameField = find.byKey(const ValueKey(SignUpKeys.nameFieldKey));
      expect(nameField, findsOneWidget);

      final emailField = find.byKey(const ValueKey(SignUpKeys.emailFieldKey));
      expect(emailField, findsOneWidget);

      final dateOfBirthField =
          find.byKey(const ValueKey(SignUpKeys.birthDateFieldKey));
      expect(dateOfBirthField, findsOneWidget);

      // Test adding a valid name
      const testName = "Kalawy";

      await tester.enterText(nameField, testName);
      await tester.pump();

      expect(find.text(testName), findsOneWidget);

      // Get a test email from webhook.site
      final webHookObject = WebHookUtils();
      final testEmail = await webHookObject.getTestEmail();

      // Test adding a valid email address
      await tester.enterText(emailField, testEmail);
      await tester.pump();

      expect(find.text(testEmail), findsOneWidget);

      await tester.tap(dateOfBirthField);
      await tester.pumpAndSettle();

      const int selectedYear = 2015;
      const int selectedMonth = 6;
      const int selectedDay = 12;
      final String fullDate =
          '$selectedYear-${formatDay(selectedMonth)}-$selectedDay';

      // Scroll to select month
      await tester.dragUntilVisible(
        find.text(getMonthName(selectedMonth)),
        find.byType(CupertinoPicker).at(0),
        const Offset(0, -50),
      );

      // Scroll to select day
      await tester.dragUntilVisible(
        find.text(selectedDay.toString()),
        find.byType(CupertinoPicker).at(1),
        const Offset(0, -50),
      );

      // Scroll to select year
      await tester.dragUntilVisible(
        find.text(selectedYear.toString()),
        find.byType(CupertinoPicker).at(2),
        const Offset(0, -50),
      );

      // Verify that the selected date is displayed
      expect(find.text(fullDate), findsOneWidget);

      final nextButton = find.byKey(const ValueKey(SignUpKeys.nextButtonKey));
      expect(nextButton, findsOneWidget);

      // Click on signUp next button
      await tester.tap(nextButton);

      // Go to signUp review page
      await tester.pumpAndSettle();

      // Get SignUp review page fields
      final reviewNameField =
          find.byKey(const ValueKey(SignUpKeys.reviewNameFieldKey));
      expect(reviewNameField, findsOneWidget);

      final reviewEmailField =
          find.byKey(const ValueKey(SignUpKeys.reviewEmailFieldKey));
      expect(reviewEmailField, findsOneWidget);

      final reviewDateOfBirthField =
          find.byKey(const ValueKey(SignUpKeys.reviewBirthDateFieldKey));
      expect(reviewDateOfBirthField, findsOneWidget);

      // Verify these fields have the right data
      expect(find.text(testName), findsOneWidget);
      expect(find.text(testEmail), findsOneWidget);
      expect(find.text(fullDate), findsOneWidget);

      final signUpButton =
          find.byKey(const ValueKey(SignUpKeys.signUpButtonKey));
      expect(signUpButton, findsOneWidget);

      // Click on signUp next button
      await tester.tap(signUpButton);

      // Go to email verification page
      await tester.pumpAndSettle();

      // Bypass captcha animation
      await tester.pumpAndSettle(const Duration(seconds: 5));
      // Wait for verification code to be received
      await tester.pumpAndSettle(const Duration(seconds: 30));

      final verificationCodeField =
          find.byKey(const ValueKey(SignUpKeys.verificationCodeFieldKey));
      expect(verificationCodeField, findsOneWidget);

      // Get the received verification code from email
      final verificationCode = await webHookObject.getSignUpToken();

      await tester.enterText(verificationCodeField, verificationCode);
      await tester.pump();

      expect(find.text(verificationCode), findsOneWidget);

      final verificationNextButton =
          find.byKey(const ValueKey(SignUpKeys.verificationNextButtonKey));
      expect(verificationNextButton, findsOneWidget);

      // Click on verification page next button
      await tester.tap(verificationNextButton);

      // Go to add password page
      await tester.pumpAndSettle();

      final addPasswordField =
          find.byKey(const ValueKey(SignUpKeys.addPasswordFieldKey));
      expect(addPasswordField, findsOneWidget);

      const testPassword = 'AaBb\$Cc123';
      await tester.enterText(addPasswordField, testPassword);
      await tester.pump();

      final addPasswordNextButton =
          find.byKey(const ValueKey(SignUpKeys.addPasswordNextButtonKey));
      expect(addPasswordNextButton, findsOneWidget);

      // Click on add password page next button
      await tester.tap(addPasswordNextButton);

      // Go to add profile pic page
      await tester.pumpAndSettle();

      final addProfilePicSkipButton =
          find.byKey(const ValueKey(SignUpKeys.addProfilePicSkipButtonKey));
      expect(addProfilePicSkipButton, findsOneWidget);

      // Click on add profile pic skip button
      await tester.tap(addProfilePicSkipButton);

      // Go to add username page
      await tester.pumpAndSettle();

      final addUsernameField =
          find.byKey(const ValueKey(SignUpKeys.userNameFieldKey));
      expect(addUsernameField, findsOneWidget);

      // Use the email token as username (Unique)
      final testUserName = await webHookObject.getTokenString();
      await tester.enterText(addUsernameField, testUserName);
      await tester.pump();

      final addUsernameNextButton =
          find.byKey(const ValueKey(SignUpKeys.addUserNameNextButtonKey));
      expect(addUsernameNextButton, findsOneWidget);

      // Click on add username next button
      await tester.tap(addUsernameNextButton);

      // Go to home page
      await tester.pumpAndSettle();

      final homePageView = find.byType(HomePage);

      // Verify that the registration process is complete
      expect(homePageView, findsOneWidget);
    });
  });
}
