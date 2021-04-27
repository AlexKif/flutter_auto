import 'package:auto/helpers/ColorToHex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final Function functionValidate;
  final Function onTap;
  final TextEditingController controller;
  final String validateText;
  final String labelText;
  final bool validate;
  final bool obscureText;
  final TextInputType fieldType;
  final int maxLines;
  final TextInputAction textInputAction;

  CustomTextFormField(
      {this.focusNode,
      this.inputFormatters,
      this.functionValidate,
      this.onTap,
      this.fieldType,
      this.controller,
      this.validate,
      this.validateText,
      this.obscureText,
      this.maxLines,
      this.textInputAction,
      this.labelText});

  @override
  State<StatefulWidget> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  Color styledLabel(hasFocus) {
    if (!widget.validate) {
      return Colors.red;
    }
    if (hasFocus) {
      return HexColor("6200EE");
    }
    return Color.fromRGBO(60, 60, 67, .3);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      focusNode: widget.focusNode,
      obscureText: widget.obscureText ?? false,
      controller: widget.controller,
      cursorColor: Colors.black,
      keyboardType: widget.fieldType,
      inputFormatters: widget.inputFormatters,
      validator: widget.functionValidate,
      maxLines: widget.maxLines ?? null,
      onTap: () {
        widget.onTap(context);
      },
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(18),
        labelStyle: TextStyle(color: styledLabel(widget.focusNode.hasFocus)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.5)),
          borderSide: BorderSide(width: 2, color: HexColor('#6200EE')),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.5)),
          borderSide: BorderSide(width: 2, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.5)),
          borderSide: BorderSide(width: 2, color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.5)),
          borderSide: BorderSide(width: 1, color: HexColor('#e0e0e0')),
        ),
        labelText: widget.labelText,
      ),
    );
  }
}
