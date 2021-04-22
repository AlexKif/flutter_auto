import 'package:auto/models/user/userForms.dart';

class SignArguments {
  final String phone;
  SignArguments({this.phone});
}

class TicketArguments {
  final UserForms ticket;
  TicketArguments({this.ticket});
}
