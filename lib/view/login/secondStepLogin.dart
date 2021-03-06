import 'package:auto/api/api.dart';
import 'package:auto/layouts/signLayout.dart';
import 'package:auto/routing/arguments.dart';
import 'package:auto/routing/routingConstants.dart';
import 'package:auto/services/storage.dart';
import 'package:auto/widgets/customLoader.dart';
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
    setState(() {
      _load = true;
    });
    login(phone, password).then((res) {
      setState(() {
        _load = false;
      });
      saveToken(res.token).then((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeViewRoute, (Route<dynamic> route) => false);
      });
    }).catchError((onError) {
      setState(() {
        _load = false;
      });
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
    Widget loadingIndicator = _load ? customLoader(context) : Container();

    void successValidation() {
      if (!_load) {
        goLogin(
            context: context,
            phone: widget.args.phone,
            password: passwordController.text);
      }
    }

    return Stack(
      children: [
        SignLayout(
          dotIndex: 1,
          actionTextForUser: '?????????????? ????????????',
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
              labelText: "?????????????? ????????????",
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
