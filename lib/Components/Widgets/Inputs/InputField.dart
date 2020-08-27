import 'package:flutter/material.dart';
import 'package:zwm_app/constants.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final Widget prefixIcon;
  final String defaultText;
  final bool obscureText;
  final TextEditingController controller;
  final Function saved;

  const InputField({
    @required this.hintText,
    this.defaultText,
    this.obscureText = false,
    this.controller,
    this.prefixIcon,
    this.saved,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: captionColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1.0),
        ),
        prefixIcon: widget.prefixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: paddingLarge),
        border: InputBorder.none,
        // hintText: widget.hintText,
        labelText: widget.hintText,
      ),
      onSaved: (value) {
        widget.saved(value);
      },
      // controller: widget.controller,
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
