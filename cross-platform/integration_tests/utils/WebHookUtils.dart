import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart';

class WebHookUtils {
  String token = "";
  Future<String> getTestEmail() async {
    if (token == "") {
      final tokenResponse =
          await http.post(Uri.parse('https://webhook.site/token'));
      final tokenData = jsonDecode(tokenResponse.body);
      token = tokenData['uuid'];
    }
    return "$token@email.webhook.site";
  }

  Future<String> getSignUpToken() async {
    final tokenResponse = await http
        .get(Uri.parse("https://webhook.site/token/$token/request/latest"));
    final tokenData = jsonDecode(tokenResponse.body);
    return tokenData['headers']['subject'][0].substring(0, 8);
  }

  Future<String> getTokenString() async {
    if (token == "") {
      final tokenResponse =
          await http.post(Uri.parse('https://webhook.site/token'));
      final tokenData = jsonDecode(tokenResponse.body);
      token = tokenData['uuid'];
    }
    return token;
  }

  Future<String> getResetPasswordVerificationCode(token) async {
    final tokenResponse = await http
        .get(Uri.parse("https://webhook.site/token/$token/request/latest"));
    final tokenData = jsonDecode(tokenResponse.body);
    final html = tokenData['text_content'];
    final document = parse(html);
    return document.querySelector('h4')!.text;
  }
}
