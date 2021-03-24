import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final int maxLines;
  final TextInputType textInputType;
  final Function(String) onChanged;
  final TextEditingController textController;
  final String label;
  final BorderRadius borderRadius;

  TextFieldComponent({
    this.maxLines = 1,
    this.textInputType = TextInputType.text,
    this.onChanged,
    this.textController,
    this.label,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      keyboardType: textInputType,
      onChanged: onChanged,
      controller: textController,
      cursorColor: Theme.of(context).inputDecorationTheme.focusColor,
      style: TextStyle(
        color: Theme.of(context).scaffoldBackgroundColor
      ),      
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        hintText: label,
        hintStyle: TextStyle(
          color: Theme.of(context).scaffoldBackgroundColor
        ),
        contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).inputDecorationTheme.fillColor
          ),
          borderRadius: borderRadius
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).inputDecorationTheme.fillColor
          ),
          borderRadius: borderRadius
        ),                
      ),
    );
  }
}