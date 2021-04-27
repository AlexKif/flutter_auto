import 'package:auto/layouts/signLayout.dart';
import 'package:auto/routing/arguments.dart';
import 'package:auto/routing/routingConstants.dart';
import 'package:auto/widgets/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpFirstStepView extends StatefulWidget {
  final SignArguments args;
  SignUpFirstStepView({this.args});
  @override
  _SignUpFirstStepViewState createState() => _SignUpFirstStepViewState();
}

class _SignUpFirstStepViewState extends State<SignUpFirstStepView> {
  FocusNode focusNode = new FocusNode();
  TextEditingController phoneController = TextEditingController();
  bool validate = true;

  String validatePhone(String value) {
    if (value == null || value.isEmpty) {
      setState(() {
        validate = false;
      });
      return 'Please enter phone';
    }
    if (!validate) {
      setState(() {
        validate = true;
      });
    }
    return null;
  }

  void onTapSignIn(BuildContext context) {
    Navigator.pushNamed(context, LoginViewFirstStepRoute);
  }

  void onFieldTap(BuildContext context) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void successValidation() {
      print('tut, ${phoneController.text}');
      Navigator.pushNamed(
        context,
        SignUpViewSecondStepRoute,
        arguments: SignArguments(phone: phoneController.text),
      );
    }

    return SignLayout(
      name: 'signUp',
      dotIndex: 0,
      actionTextForUser: 'Введите ваш номер телефона',
      focusNode: focusNode,
      validate: validate,
      value: phoneController.text,
      successValidation: successValidation,
      onTapSign: onTapSignIn,
      textField: CustomTextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: phoneController,
          maxLines: 1,
          fieldType: TextInputType.number,
          focusNode: focusNode,
          onTap: onFieldTap,
          functionValidate: validatePhone,
          labelText: "Введите номер телефона",
          validate: validate),
    );
  }
}
