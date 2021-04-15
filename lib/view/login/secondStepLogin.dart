import 'package:auto/api/api.dart';
import 'package:auto/layouts/signLayout.dart';
import 'package:auto/models/user/user.dart';
import 'package:auto/providers/userProvider.dart';
import 'package:auto/routing/arguments.dart';
import 'package:auto/routing/routingConstants.dart';
import 'package:auto/services/storage.dart';
import 'package:auto/widgets/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void saveToken(token) {
    secureStorage.writeSecureData('token', token);
  }

  void goLogin({context, phone, password}) {
    print('$phone, $password');
    login(phone, password).then((res) {
      print(res.token);
      saveToken(res.token);
      Provider.of<UserProvider>(context, listen: false).setUserData(res);
      // Navigator.pushNamed(context, HomeViewRoute);
      // Navigator.pushReplacementNamed(context, HomeViewRoute);
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeViewRoute, (Route<dynamic> route) => false);
      // print('Phone: ${value.phone}, Token: ${value.token}');
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
