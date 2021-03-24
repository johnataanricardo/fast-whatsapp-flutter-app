import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_start_conversation/model/chat.dart';
import 'package:whatsapp_start_conversation/screens/fastWhatsapp/components/app_header.dart';
import 'package:whatsapp_start_conversation/screens/fastWhatsapp/components/whatsapp_form.dart';

class FastWhatsapp extends StatelessWidget {
  final bool isIOS = Platform.isIOS;
  final bool isPortuguese;

  FastWhatsapp({this.isPortuguese});

  void _startConversation(Chat chat) {
    _launchURL('https://api.whatsapp.com/send/?phone=${chat.phoneNumber}&text=${chat.message}');
  }

  void _copyLinkToClipboard(Chat chat) {
    Clipboard.setData(
      ClipboardData(
        text: 'https://api.whatsapp.com/send/?phone=${chat.phoneNumber}&text=${chat.message}'
      )
    );
  }

  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  AppHeader(isPortuguese: isPortuguese),
                  WhatsAppForm(
                    isPortuguese: isPortuguese,
                    onSubmitStartConversation: _startConversation,
                    onSubmitCopyLinkToClipboard: _copyLinkToClipboard
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}