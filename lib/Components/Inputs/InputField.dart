import 'package:flutter/material.dart';

/// *  textInputType - The type of information for which to optimize the text input control.
/// *  hintText - Text that suggests what sort of input the field accepts.
/// *  prefixIcon - Pass Icon if required
/// *  defaultText - If there is predefined value is there for a text field
/// *  focusNode - Currently focus node
/// *  obscureText - Is Password field?
/// *  controller - Text controller
/// *  functionValidate - Validation function(currently I have used to check empty field)
/// *  parametersValidate - Value to validate
/// *  actionKeyboard - Keyboard action eg. next, done, search, etc
/// *  onSubmitField - Done click action
/// *  onFieldTap - On focus on TextField
class InputField extends StatefulWidget {
  final String hintText;
  final Widget prefixIcon;
  final String defaultText;
  final bool obscureText;
  final TextEditingController controller;

  const InputField({
    @required this.hintText,
    this.defaultText,
    this.obscureText = false,
    this.controller,
    this.prefixIcon,
    borderColor,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isFocused ? Theme.of(context).primaryColor : Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Focus(
              child: TextField(
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                    prefixIcon: widget.prefixIcon,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    border: InputBorder.none,
                    hintText: widget.hintText),
                controller: widget.controller,
              ),
              onFocusChange: (hasFocus) {
                setState(() {
                  isFocused = hasFocus;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

String commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}

String requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
