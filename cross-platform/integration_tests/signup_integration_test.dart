import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tweaxy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:tweaxy/shared/keys/sign_up_keys.dart';
import 'package:tweaxy/shared/errors/validation_errors.dart';
import './utils/WebHookUtils.dart';
import 'package:tweaxy/views/homepage.dart';
import 'package:tweaxy/views/signup/mobile/create_account_view.dart';

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
    testWidgets('SignUp with right inputs (Good Path)', (tester) async {
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

    testWidgets('SignUp first page with untrimmed empty inputs',
        (tester) async {
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

      // Test adding an empty untrimmed name
      const emptyTestName = ' ';
      await tester.enterText(nameField, emptyTestName);
      await tester.pump();
      expect(find.text(ValidationErrors.emptyNameError), findsOneWidget);

      // Test adding an empty untrimmed email address
      const emptyTestEmail = ' ';
      await tester.enterText(emailField, emptyTestEmail);
      await tester.pump();
      expect(find.text(ValidationErrors.emptyEmailError), findsOneWidget);

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

      final createAccountView = find.byType(CreateAccountView);
      expect(createAccountView, findsOneWidget);

      // Try to add a valid name then valid email to test if one of them is broken
      const testEmail = 'valid@domain.com';
      await tester.enterText(emailField, testEmail);
      await tester.pump();
      expect(find.text(ValidationErrors.emptyEmailError), findsNothing);
      expect(find.text(testEmail), findsOneWidget);

      // Click on signUp next button
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      expect(createAccountView, findsOneWidget);

      const testName = 'validName';
      await tester.enterText(nameField, testName);
      await tester.pump();
      expect(find.text(ValidationErrors.emptyEmailError), findsNothing);
      expect(find.text(testName), findsOneWidget);
    });
    testWidgets('SignUp first page with empty inputs', (tester) async {
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

      // Test adding an empty untrimmed name
      const emptyTestName = '';
      await tester.enterText(nameField, emptyTestName);
      await tester.pump();
      expect(find.text(ValidationErrors.emptyNameError), findsOneWidget);

      // Test adding an empty untrimmed email address
      const emptyTestEmail = '';
      await tester.enterText(emailField, emptyTestEmail);
      await tester.pump();
      expect(find.text(ValidationErrors.emptyEmailError), findsOneWidget);

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

      final createAccountView = find.byType(CreateAccountView);
      expect(createAccountView, findsOneWidget);

      // Try to add a valid name then valid email to test if one of them is broken
      const testEmail = 'valid@domain.com';
      await tester.enterText(emailField, testEmail);
      await tester.pump();
      expect(find.text(ValidationErrors.emptyEmailError), findsNothing);
      expect(find.text(testEmail), findsOneWidget);

      // Click on signUp next button
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      expect(createAccountView, findsOneWidget);

      const testName = 'validName';
      await tester.enterText(nameField, testName);
      await tester.pump();
      expect(find.text(ValidationErrors.emptyEmailError), findsNothing);
      expect(find.text(testName), findsOneWidget);
    });
    testWidgets('SignUp with invalid inputs', (tester) async {
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
      const testName = "Kalawy"; // Empty name is already tested

      await tester.enterText(nameField, testName);
      await tester.pump();

      expect(find.text(testName), findsOneWidget);

      // Get a test email from webhook.site
      final webHookObject = WebHookUtils();
      final testEmail = await webHookObject.getTestEmail();
      const invalidTestEmail1 = 'test.io.com';
      const invalidTestEmail2 = 'test@io@epam.com';
      const invalidTestEmail3 = 'test(io"epam)example]com';
      const invalidTestEmail4 = '.test... io\today@epam.com ';

      // Test adding invalid email email addresses
      await tester.enterText(emailField, invalidTestEmail1);
      await tester.pump();

      expect(find.text(ValidationErrors.invalidEmailError), findsOneWidget);

      await tester.enterText(emailField, invalidTestEmail2);
      await tester.pump();

      expect(find.text(ValidationErrors.invalidEmailError), findsOneWidget);

      await tester.enterText(emailField, invalidTestEmail3);
      await tester.pump();

      expect(find.text(ValidationErrors.invalidEmailError), findsOneWidget);

      await tester.enterText(emailField, invalidTestEmail4);
      await tester.pump();

      expect(find.text(ValidationErrors.invalidEmailError), findsOneWidget);

      // Adding the valid email
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
      final emptyTestCode = '';
      final emptyUntrimmedCode = ' ';
      final shortCode = '1234';

      await tester.enterText(verificationCodeField, emptyTestCode);
      await tester.pump();

      expect(find.text(ValidationErrors.emptyCodeError), findsOneWidget);

      await tester.enterText(verificationCodeField, emptyUntrimmedCode);
      await tester.pump();

      expect(find.text(ValidationErrors.emptyCodeError), findsOneWidget);

      await tester.enterText(verificationCodeField, shortCode);
      await tester.pump();

      expect(find.text(ValidationErrors.codeLengthError), findsOneWidget);

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
      const testShortPassword = 'aA1\$';
      const testNoSmallPassword = 'A11111\&A';
      const testNoCapitalPassword = 'a11111\&a';
      const testNoNumberPassword = 'Aaaaaa\&A';
      const testNoSpecialPassword = 'AaaaaabA';

      await tester.enterText(addPasswordField, testShortPassword);
      await tester.pump();
      expect(find.text(ValidationErrors.passwordLengthError), findsOneWidget);

      await tester.enterText(addPasswordField, testNoSmallPassword);
      await tester.pump();
      expect(
          find.text(ValidationErrors.passwordSmallLetterError), findsOneWidget);
      expect(find.text(ValidationErrors.passwordLengthError), findsNothing);

      await tester.enterText(addPasswordField, testNoCapitalPassword);
      await tester.pump();
      expect(find.text(ValidationErrors.passwordCapitalLetterError),
          findsOneWidget);
      expect(
          find.text(ValidationErrors.passwordSmallLetterError), findsNothing);

      await tester.enterText(addPasswordField, testNoNumberPassword);
      await tester.pump();
      expect(find.text(ValidationErrors.passwordNumberError), findsOneWidget);
      expect(
          find.text(ValidationErrors.passwordCapitalLetterError), findsNothing);

      await tester.enterText(addPasswordField, testNoSpecialPassword);
      await tester.pump();
      expect(find.text(ValidationErrors.passwordSpecialCharacterError),
          findsOneWidget);
      expect(find.text(ValidationErrors.passwordNumberError), findsNothing);

      await tester.enterText(addPasswordField, testPassword);
      await tester.pump();

      expect(find.text(ValidationErrors.passwordSpecialCharacterError),
          findsNothing);

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
      const testShortUsername = 'cr7';
      const testEmptyUsername = '';
      const testEmptyUntrimmedUsername = ' ';

      await tester.enterText(addUsernameField, testShortUsername);
      await tester.pump();
      expect(find.text(ValidationErrors.usernameLengthError), findsOneWidget);

      await tester.enterText(addUsernameField, testEmptyUsername);
      await tester.pump();
      expect(find.text(ValidationErrors.emptyUsernameError), findsOneWidget);

      await tester.enterText(addUsernameField, testEmptyUntrimmedUsername);
      await tester.pump();
      expect(find.text(ValidationErrors.emptyUsernameError), findsOneWidget);

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