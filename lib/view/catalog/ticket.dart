import 'package:auto/layouts/appBarLayout.dart';
import 'package:auto/routing/arguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  final TicketArguments args;
  Ticket({this.args});

  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    print(widget.args.ticket.content);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBarLayout(
          title: 'Запрос',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0, 1),
                      blurRadius: 3)
                ]),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.network(widget.args.ticket.image.medium,
                      fit: BoxFit.cover),
                ),
                SizedBox(height: 12),
                Text(
                  widget.args.ticket.content,
                  style: TextStyle(
                      fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.87)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
