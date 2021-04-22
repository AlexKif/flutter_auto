import 'dart:convert';
import 'package:auto/models/sign.dart';
import 'package:auto/models/user/user.dart';
import 'package:auto/models/user/userForms.dart';
import 'package:auto/services/storage.dart';
import 'package:http/http.dart' as http;

Future<User> login(phone, password) async {
  var response = await http.post(
    Uri.https('api.test.auto.fmc-dev.com', 'api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'phone': phone,
      'password': password,
    }),
  );
  print('status ${response.body}');
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(jsonDecode(response.body)['message']);
  }
}

Future<SignUpModel> registration(phone, password) async {
  var response = await http.post(
    Uri.https('api.test.auto.fmc-dev.com', 'api/registration'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'phone': phone,
      'password': password,
    }),
  );
  if (response.statusCode == 201) {
    return SignUpModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to Sign Up');
  }
}

Future<LogoutModel> logout(token) async {
  var response = await http.get(
    Uri.https('api.test.auto.fmc-dev.com', 'api/logout'),
    headers: <String, String>{
      'AUTH-TOKEN': token,
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    return LogoutModel('Success Logout');
  } else {
    throw Exception('Failed to Logout');
  }
}

Future<List<UserForms>> getForms() async {
  SecureStorage storage = SecureStorage();
  String token = await storage.readSecureData('token');
  var response = await http.get(
    Uri.https('api.test.auto.fmc-dev.com', 'api/form'),
    headers: <String, String>{
      'AUTH-TOKEN': token,
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    List<UserForms> forms =
        List<UserForms>.from(l.map((model) => UserForms.fromJson(model)));
    return forms;
  } else {
    print('error');
    throw Exception(jsonDecode(response.body)['message']);
  }
}
