import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

abstract class BaseEmail{
  void sendMessage(String email,String message);
  void sendHtml(String email,String message);
  void sendFiles(String email,File file);
}

class Email extends BaseEmail{
  
  @override
  void sendFiles(String email, File file) {
  }

  @override
  void sendHtml(String email, String message) {
    // TODO: implement sendHtml
  }

  //多级试图连接
  @override
  void sendMessage(String email, String message) {
    final smtpServer = qq('869232913', 'Dooim@zhenio23');
    final message = Message()
      ..from = Address('869232913', 'Your name')
      ..recipients.add('destination@example.com')
      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

  }

}