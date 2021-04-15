import 'package:auto/layouts/appBarLayout.dart';
import 'package:auto/providers/userProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: AppBarLayout(),
        ),
        body: Consumer<UserProvider>(
          builder: (context, user, child) {
            return ListView.builder(
              itemCount: user.getUserData().forms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${user.getUserData().forms[index].content}'),
                );
              },
            );
          },
        ));
  }
}
