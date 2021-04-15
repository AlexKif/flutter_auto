import 'package:auto/api/api.dart';
import 'package:auto/routing/routingConstants.dart';
import 'package:auto/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppBarLayoutState();
}

class _AppBarLayoutState extends State<AppBarLayout> {
  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Внимание', style: TextStyle(fontSize: 14)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Вы действительно хотите выйти из своего аккаунта?',
                  style: TextStyle(
                      fontSize: 14, color: Color.fromRGBO(0, 0, 0, .6)),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('НЕТ',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(98, 0, 238, 1),
                      fontFamily: 'RobotoMedium')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ДА',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(98, 0, 238, 1),
                      fontFamily: 'RobotoMedium')),
              onPressed: () {
                logoutHandler(context);
              },
            ),
          ],
        );
      },
    );
  }

  void logoutHandler(BuildContext context) async {
    SecureStorage storage = SecureStorage();
    String token = await storage.readSecureData('token');
    logout(token).then((value) async {
      await storage.deleteSecureData('token');
      Navigator.pushNamed(
        context,
        LoginViewFirstStepRoute,
      );
    }).catchError((onError) async {
      await storage.deleteSecureData('token');
      Navigator.pushNamed(
        context,
        LoginViewFirstStepRoute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
          child: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            showMyDialog(context);
          },
        ),
        backgroundColor: Color.fromRGBO(98, 0, 238, 1),
        title: Row(
          children: [
            // SizedBox(
            //   width: 30,
            // ),
            Text('Мои запросы')
          ],
        ));
  }
}
