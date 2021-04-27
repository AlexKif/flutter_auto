import 'package:auto/layouts/signLayout.dart';
import 'package:auto/routing/arguments.dart';
import 'package:auto/routing/routingConstants.dart';
import 'package:auto/widgets/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginFirstStepView extends StatefulWidget {
  @override
  _LoginFirstStepState createState() => _LoginFirstStepState();
}

class _LoginFirstStepState extends State<LoginFirstStepView> {
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

  void onTapSignUp(BuildContext context) {
    Navigator.pushNamed(context, SignUpViewFirstStepRoute);
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
      Navigator.pushNamed(
        context,
        LoginViewSecondStepRoute,
        arguments: SignArguments(phone: phoneController.text),
      );
    }

    return SignLayout(
      dotIndex: 0,
      actionTextForUser: 'Введите ваш номер телефона',
      focusNode: focusNode,
      validate: validate,
      value: phoneController.text,
      name: 'signIn',
      successValidation: successValidation,
      onTapSign: onTapSignUp,
      textField: CustomTextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: phoneController,
          fieldType: TextInputType.number,
          maxLines: 1,
          focusNode: focusNode,
          onTap: onFieldTap,
          functionValidate: validatePhone,
          labelText: "Введите номер телефона",
          validate: validate),
    );
  }
}
