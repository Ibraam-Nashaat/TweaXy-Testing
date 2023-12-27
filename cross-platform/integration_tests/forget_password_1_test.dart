import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/main.dart' as app;
import 'package:tweaxy/shared/errors/validation_errors.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import './utils/WebHookUtils.dart';
import 'utils/registered_users.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final token = users[1][0].substring(0, users[1][0].indexOf('@'));

  group('Forget Password Tests from Sign In Enter Email Screen:', () {
    testWidgets('Change Password successfully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var forgetPasswordButton =
          find.byKey(const ValueKey(SignInKeys.forgetPasswordButtonKey));
      await tester.tap(forgetPasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var forgetPassEmailTextField =
          find.byKey(const ValueKey(SignInKeys.forgetPasswordEmailFieldKey));
      await tester.enterText(forgetPassEmailTextField, users[1][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      expect(nextButton, findsOneWidget);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      var verificationCodeTextField = find
          .byKey(const ValueKey(SignInKeys.forgetPasswordVerificationFieldKey));

      final webHook = WebHookUtils();
      await tester.pumpAndSettle(const Duration(seconds: 10));
      final verificationCode =
          await webHook.getResetPasswordVerificationCode(token);
      print(verificationCode);
      await tester.enterText(verificationCodeTextField, verificationCode);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var newPasswordTextField = find
          .byKey(const ValueKey(SignInKeys.forgetPasswordNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, users[1][1]);
      newPasswordTextField = find.byKey(
          const ValueKey(SignInKeys.forgetPasswordConfirmNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, users[1][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      nextButton = find
          .byKey(const ValueKey(SignInKeys.forgetPasswordContinueButtonKey));
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text('For you'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('Sign in Successfully after changing password',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[1][0]);

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[1][1]);
      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text('For you'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('Change password with unregistered email',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var forgetPasswordButton =
          find.byKey(const ValueKey(SignInKeys.forgetPasswordButtonKey));
      await tester.tap(forgetPasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var forgetPassEmailTextField =
          find.byKey(const ValueKey(SignInKeys.forgetPasswordEmailFieldKey));
      await tester.enterText(forgetPassEmailTextField, 'ahmed@gmail.com');
      await tester.pumpAndSettle(const Duration(seconds: 1));
      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(
          find.text(
              'Enter the email, phone number or username associated with your account to change your password'),
          findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('Change password with wrong verification code',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var forgetPasswordButton =
          find.byKey(const ValueKey(SignInKeys.forgetPasswordButtonKey));
      await tester.tap(forgetPasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var forgetPassEmailTextField =
          find.byKey(const ValueKey(SignInKeys.forgetPasswordEmailFieldKey));
      await tester.enterText(forgetPassEmailTextField, users[1][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      expect(nextButton, findsOneWidget);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var verificationCodeTextField = find
          .byKey(const ValueKey(SignInKeys.forgetPasswordVerificationFieldKey));
      await tester.pumpAndSettle(const Duration(seconds: 10));
      await tester.enterText(verificationCodeTextField, "789dgv23");
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('We sent you a code'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets(
        'Change password with unmatching new password and confirmation new password',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var forgetPasswordButton =
          find.byKey(const ValueKey(SignInKeys.forgetPasswordButtonKey));
      await tester.tap(forgetPasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var forgetPassEmailTextField =
          find.byKey(const ValueKey(SignInKeys.forgetPasswordEmailFieldKey));
      await tester.enterText(forgetPassEmailTextField, users[1][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      expect(nextButton, findsOneWidget);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      var verificationCodeTextField = find
          .byKey(const ValueKey(SignInKeys.forgetPasswordVerificationFieldKey));

      final webHook = WebHookUtils();
      await tester.pumpAndSettle(const Duration(seconds: 10));
      final verificationCode =
          await webHook.getResetPasswordVerificationCode(token);
      print(verificationCode);
      await tester.enterText(verificationCodeTextField, verificationCode);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var newPasswordTextField = find
          .byKey(const ValueKey(SignInKeys.forgetPasswordNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, 'Kalawy@1234');
      newPasswordTextField = find.byKey(
          const ValueKey(SignInKeys.forgetPasswordConfirmNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, 'Kalawy@5679');
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Enter a new password'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets(
        'Change password with new password having different validation errors',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      var logInButton =
          find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var forgetPasswordButton =
          find.byKey(const ValueKey(SignInKeys.forgetPasswordButtonKey));
      await tester.tap(forgetPasswordButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var forgetPassEmailTextField =
          find.byKey(const ValueKey(SignInKeys.forgetPasswordEmailFieldKey));
      await tester.enterText(forgetPassEmailTextField, users[1][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      expect(nextButton, findsOneWidget);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var verificationCodeTextField = find
          .byKey(const ValueKey(SignInKeys.forgetPasswordVerificationFieldKey));
      final webHook = WebHookUtils();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      final verificationCode =
          await webHook.getResetPasswordVerificationCode(token);
      print(verificationCode);
      await tester.enterText(verificationCodeTextField, verificationCode);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Password length error
      var newPasswordTextField = find
          .byKey(const ValueKey(SignInKeys.forgetPasswordNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, 'Kalawy');
      newPasswordTextField = find.byKey(
          const ValueKey(SignInKeys.forgetPasswordConfirmNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, 'Kalawy');
      await tester.pumpAndSettle(const Duration(seconds: 1));
      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text(ValidationErrors.passwordLengthError), findsNWidgets(2));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Password missing special character error
      newPasswordTextField = find
          .byKey(const ValueKey(SignInKeys.forgetPasswordNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, 'Kalawy12');
      newPasswordTextField = find.byKey(
          const ValueKey(SignInKeys.forgetPasswordConfirmNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, 'Kalawy12');
      await tester.pumpAndSettle(const Duration(seconds: 1));
      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text(ValidationErrors.passwordSpecialCharacterError),
          findsNWidgets(2));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //Password missing capital letter error
      newPasswordTextField = find
          .byKey(const ValueKey(SignInKeys.forgetPasswordNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, 'kalawy@1234');
      newPasswordTextField = find.byKey(
          const ValueKey(SignInKeys.forgetPasswordConfirmNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, 'kalawy@1234');
      await tester.pumpAndSettle(const Duration(seconds: 1));
      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text(ValidationErrors.passwordCapitalLetterError),
          findsNWidgets(2));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //Password missing number error
      newPasswordTextField = find
          .byKey(const ValueKey(SignInKeys.forgetPasswordNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, 'Kalawy@K');
      newPasswordTextField = find.byKey(
          const ValueKey(SignInKeys.forgetPasswordConfirmNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, 'Kalawy@K');
      await tester.pumpAndSettle(const Duration(seconds: 1));
      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text(ValidationErrors.passwordNumberError), findsNWidgets(2));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //Password missing small letter error
      newPasswordTextField = find
          .byKey(const ValueKey(SignInKeys.forgetPasswordNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, 'KALAWY@1234');
      newPasswordTextField = find.byKey(
          const ValueKey(SignInKeys.forgetPasswordConfirmNewPasswordFieldKey));
      await tester.enterText(newPasswordTextField, 'KALAWY@1234');
      await tester.pumpAndSettle(const Duration(seconds: 1));
      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text(ValidationErrors.passwordSmallLetterError),
          findsNWidgets(2));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });
  });
}
