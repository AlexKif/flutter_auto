import 'package:auto/api/api.dart';
import 'package:auto/layouts/signLayout.dart';
import 'package:auto/routing/arguments.dart';
import 'package:auto/routing/routingConstants.dart';
import 'package:auto/services/storage.dart';
import 'package:auto/widgets/customLoader.dart';
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
  bool _load = false;
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
    setState(() {
      _load = true;
    });
    registration(phone, password).then((res) {
      setState(() {
        _load = false;
      });
      showMyDialog(context, res.token);
    }).catchError((_) {
      setState(() {
        _load = false;
      });
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
    Widget loadingIndicator = _load ? customLoader(context) : Container();

    void successValidation() {
      if (!_load) {
        goRegistration(
            context: context,
            phone: widget.args.phone,
            password: passwordController.text);
      }
    }

    return Stack(
      children: [
        SignLayout(
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
              maxLines: 1,
              controller: passwordController,
              obscureText: true,
              onTap: onFieldTap,
              focusNode: focusNode,
              functionValidate: validatePassword,
              labelText: "Введите пароль",
              validate: validate),
        ),
        Align(
          child: loadingIndicator,
          alignment: FractionalOffset.center,
        ),
      ],
    );
  }
}
