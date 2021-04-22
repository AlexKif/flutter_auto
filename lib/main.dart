import 'package:auto/providers/sign.dart';
import 'package:auto/providers/userProvider.dart';
import 'package:auto/routing/routing.dart';
import 'package:auto/routing/routingConstants.dart';
import 'package:auto/services/storage.dart';
import 'package:auto/view/catalog/catalogHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SecureStorage storage = SecureStorage();
  await storage.readSecureData('token').then((res) {
    // token = null;
    token = res;
    print(res);
  });
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SignViewModel()),
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
            child: CatalogHomeView(),
          ),
        ],
        child: MaterialApp(
            initialRoute:
                token != null ? HomeViewRoute : LoginViewFirstStepRoute,
            onGenerateRoute: generateRoute));
  }
}
