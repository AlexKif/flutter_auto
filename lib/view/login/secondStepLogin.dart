import 'package:auto/api/api.dart';
import 'package:auto/layouts/signLayout.dart';
import 'package:auto/routing/arguments.dart';
import 'package:auto/routing/routingConstants.dart';
import 'package:auto/services/storage.dart';
import 'package:auto/widgets/customTextFormField.dart';
import 'package:flutter/material.dart';

class LoginSecondStepView extends StatefulWidget {
  final SignArguments args;
  LoginSecondStepView({this.args});
  @override
  _LoginSecondStepState createState() => _LoginSecondStepState();
}

class _LoginSecondStepState extends State<LoginSecondStepView> {
  FocusNode focusNode = new FocusNode();
  TextEditingController passwordController = TextEditingController();
  bool validate = true;
  final SecureStorage secureStorage = SecureStorage();

  String validatePassword(String value) {
    if (value == null || value.isEmpty) {
      setState(() {
        validate = false;
      });
      return 'Please enter phone';
    }
    if (value != null && value.length < 8) {
      setState(() {
        validate = false;
      });
      return 'Password is short';
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

  Future<void> saveToken(token) async {
    await secureStorage.writeSecureData('token', token);
  }

  void goLogin({context, phone, password}) {
    print('$phone, $password');
    login(phone, password).then((res) {
      saveToken(res.token).then((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeViewRoute, (Route<dynamic> route) => false);
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void successValidation() {
      goLogin(
          context: context,
          phone: widget.args.phone,
          password: passwordController.text);
    }

    return SignLayout(
      dotIndex: 1,
      actionTextForUser: 'Введите пароль',
      focusNode: focusNode,
      validate: validate,
      name: 'signIn',
      value: passwordController.text,
      onTapSign: onTapSignUp,
      successValidation: successValidation,
      textField: CustomTextFormField(
          inputFormatters: [],
          maxLines: 1,
          controller: passwordController,
          obscureText: true,
          onTap: onFieldTap,
          focusNode: focusNode,
          functionValidate: validatePassword,
          labelText: "Введите пароль",
          validate: validate),
    );
  }
}
