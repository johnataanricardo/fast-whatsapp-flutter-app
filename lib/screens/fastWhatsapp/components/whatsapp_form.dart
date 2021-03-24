import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_start_conversation/model/chat.dart';
import 'package:whatsapp_start_conversation/screens/fastWhatsapp/components/text_field_component.dart';

class WhatsAppForm extends StatefulWidget {
  final bool isPortuguese;
  final void Function(Chat) onSubmitStartConversation;
  final void Function(Chat) onSubmitCopyLinkToClipboard;

  WhatsAppForm({
    this.isPortuguese, 
    this.onSubmitStartConversation,
    this.onSubmitCopyLinkToClipboard
  });

  @override
  _WhatsAppFormState createState() => _WhatsAppFormState();
}

class _WhatsAppFormState extends State<WhatsAppForm> {
  String _ddi;
  List _ddiList = [];
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  Chat _chat = Chat();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _loadDDIList();
  }

  Future<void> _loadDDIList() async {
    final String response = await rootBundle.loadString('assets/json/ddi.json');
    final data = await json.decode(response);
    setState(() {
      _ddiList = data;
    });
  } 

  _setDDI(String ddi) {
    _saveDDIPreference(ddi);
    setState(() {
      _ddi = ddi;
    });
  }

  _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _ddi = prefs.getString('ddi') ?? '+55';
    });
  }

  _saveDDIPreference(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ddi', value);
  }

  _createChat() {
    final phoneNumber = _phoneController.text;
    final message = _messageController.text;    
    setState(() {
      _chat = Chat(        
        phoneNumber: _ddi + phoneNumber,
        message: message
      );
    });
  }
  
  _submit(String type) {
    if (_chat.phoneNumber == null || _chat.phoneNumber == '') {
      final snackBar = SnackBar(
        elevation: 1000,
        padding: EdgeInsets.all(10),
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0)
          )
        ),
        content: Text(
          widget.isPortuguese ? 'Telefone é obrigatório!' : 'Phone Number is required!',
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.button.color,
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
        ),
        action: SnackBarAction(
          label: widget.isPortuguese ? 'Fechar' : 'Close',
          textColor: Theme.of(context).primaryTextTheme.button.color,
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (type == 'copy') {
      widget.onSubmitCopyLinkToClipboard(_chat);
    } else {
      widget.onSubmitStartConversation(_chat);
    }
    _phoneController.clear();
    _messageController.clear();
    setState(() {
      _chat = Chat(
        phoneNumber: '',
        message: ''
      );
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_ddiList != null)
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField(      
                    value: _ddi,
                    dropdownColor: Theme.of(context).inputDecorationTheme.fillColor,
                    isExpanded: true,
                    items: [..._ddiList].map((ddi) {
                      return DropdownMenuItem<String>(  
                        value: '${ddi['dial_code']}',
                        child: Text(
                          '${ddi['dial_code']} ${ddi['name']}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor
                          ), 
                        )
                      );
                    }).toList(),
                    decoration: InputDecoration(                      
                      filled: true,
                      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                      hintText: 'DDI',
                      hintStyle: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor
                      ),
                      contentPadding:
                        const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).inputDecorationTheme.fillColor
                        ),
                           borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(25.7),
                        )
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).inputDecorationTheme.fillColor
                        ),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(25.7),
                        )
                      ),                
                    ),
                    onChanged: (ddi) => _setDDI(ddi),
                  ),
                ),
                SizedBox(width: 0.3),
                Expanded(
                  flex: 4,
                  child: TextFieldComponent(
                    textInputType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => _createChat(),
                    textController: _phoneController,
                    label: widget.isPortuguese ? 'Número do Telefone' : 'Phone Number',
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(25.7)
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextFieldComponent(
              maxLines: 5,
              onChanged: (_) => _createChat(),
              textController: _messageController,
              label: widget.isPortuguese ? 'Mensagem' : 'Message',
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(25.7),
                right: Radius.circular(25.7)
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5)
                    ),
                  ),
                  child: Text(
                    widget.isPortuguese ? 'Copiar Link' : 'Copy Link',
                    style: Theme.of(context).primaryTextTheme.button
                  ),
                  onPressed: () => _submit('copy'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5)
                    ),
                  ),
                  child: Text(
                    widget.isPortuguese ? 'Começar Conversa' : 'Start WhatsApp',
                    style: Theme.of(context).primaryTextTheme.button
                  ),
                  onPressed: () => _submit('start'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}