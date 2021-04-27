import 'package:auto/routing/routingConstants.dart';
import 'package:auto/view/catalog/catalogHome.dart';
import 'package:auto/view/catalog/createTicket.dart';
import 'package:auto/view/catalog/ticket.dart';
import 'package:auto/view/login/firstStepLogin.dart';
import 'package:auto/view/login/secondStepLogin.dart';
import 'package:auto/view/signUp/signUpFirsStep.dart';
import 'package:auto/view/signUp/signUpSecondStep.dart';
import 'package:flutter/material.dart';

import 'arguments.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => CatalogHomeView());

    case LoginViewFirstStepRoute:
      return MaterialPageRoute(builder: (context) => LoginFirstStepView());

    case LoginViewSecondStepRoute:
      SignArguments args = settings.arguments as SignArguments;
      return MaterialPageRoute(
          builder: (context) => LoginSecondStepView(args: args));

    case SignUpViewFirstStepRoute:
      return MaterialPageRoute(builder: (context) => SignUpFirstStepView());

    case CreateTicketViewRoute:
      return MaterialPageRoute(builder: (context) => CreateTicket());

    case TicketViewRoute:
      TicketArguments args = settings.arguments as TicketArguments;
      return MaterialPageRoute(
          builder: (context) => Ticket(
                args: args,
              ));

    case SignUpViewSecondStepRoute:
      SignArguments args = settings.arguments as SignArguments;
      return MaterialPageRoute(
          builder: (context) => SignUpSecondStepView(args: args));

    default:
      return MaterialPageRoute(builder: (context) => CatalogHomeView());
  }
}
