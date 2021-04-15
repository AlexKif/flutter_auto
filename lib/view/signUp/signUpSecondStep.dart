import 'package:auto/api/api.dart';
import 'package:auto/layouts/signLayout.dart';
import 'package:auto/routing/arguments.dart';
import 'package:auto/routing/routingConstants.dart';
import 'package:auto/services/storage.dart';
import 'package:auto/widgets/customTextFormField.dart';
import 'package:flutter/material.dart';

class SignUpSecondStepView extends StatefulWidget {
  final SignArguments args;
  SignUpSecondStepView({this.args});
  @override
  _SignUpSecondStepViewState createState() => _SignUpSecondStepViewState();
}

class _SignUpSecondStepViewState extends State<SignUpSecondStepView> {
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

  void onTapSignIn(BuildContext context) {
    Navigator.pushNamed(context, LoginViewFirstStepRoute);
  }

  void onFieldTap(BuildContext context) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  void saveToken(token) async {
    secureStorage.writeSecureData('token', token);
  }

  Future<void> showMyDialog(BuildContext context, String token) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Успех!', style: TextStyle(fontSize: 14)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Поздравляем!',
                  style: TextStyle(
                      fontSize: 14, color: Color.fromRGBO(0, 0, 0, .6)),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Вы успешно создали аккаунт',
                  style: TextStyle(
                      fontSize: 14, color: Color.fromRGBO(0, 0, 0, .6)),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ПОНЯТНО',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(98, 0, 238, 1),
                      fontFamily: 'RobotoMedium')),
              onPressed: () {
                saveToken(token);
                Navigator.pushNamed(context, HomeViewRoute);
              },
            ),
          ],
        );
      },
    );
  }

  void goRegistration({context, phone, password}) {
    print('$phone, $password');
    registration(phone, password).then((res) {
      showMyDialog(context, res.token);
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
      print('${widget.args.phone}, ${passwordController.text}');
      goRegistration(
          context: context,
          phone: widget.args.phone,
          password: passwordController.text);
    }

    return SignLayout(
      dotIndex: 1,
      actionTextForUser: 'Введите пароль',
      focusNode: focusNode,
      validate: validate,
      name: 'signUp',
      value: passwordController.text,
      onTapSign: onTapSignIn,
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
