import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AppHeader extends StatelessWidget {
  final bool isPortuguese;

  AppHeader({this.isPortuguese});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.message,
                size: 35,
                color: Theme.of(context).primaryTextTheme.headline5.color,
              ),
              SizedBox(width: 15),
              Text(
                isPortuguese ? 'WhatsApp Rápido' : 'Fast WhatsApp',
                style: Theme.of(context).primaryTextTheme.headline5
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: AutoSizeText(
                  isPortuguese ? 
                    'Comece uma conversa no WhatsApp sem poluir sua agenda de contatos!' 
                    : 'Start WhatsApp chat without dirty your contact list!',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  style: Theme.of(context).primaryTextTheme.headline6
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}