import 'package:auto/api/api.dart';
import 'package:auto/layouts/appBarLayout.dart';
import 'package:auto/models/user/userForms.dart';
import 'package:auto/routing/arguments.dart';
import 'package:auto/routing/routingConstants.dart';
import 'package:flutter/material.dart';

class CatalogHomeView extends StatefulWidget {
  @override
  _CatalogHomeViewState createState() => _CatalogHomeViewState();
}

class _CatalogHomeViewState extends State<CatalogHomeView> {
  // Future<String> formsData;

  @override
  void initState() {
    super.initState();
  }

  void ticketTap(UserForms ticket) {
    Navigator.pushNamed(context, TicketViewRoute,
        arguments: TicketArguments(ticket: ticket));
  }

  @override
  Widget build(BuildContext context) {
    void logout() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            LoginViewFirstStepRoute, (Route<dynamic> route) => false);
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBarLayout(leadingAction: 'logout', title: 'Мои запросы'),
      ),
      body: Column(
        children: [
          Flexible(
            child: FutureBuilder<List<UserForms>>(
                future: getForms(),
                builder: (context, snapshot) {
                  if (snapshot.hasError &&
                      snapshot.connectionState == ConnectionState.none) {
                    print('not show');
                    logout();
                    return Text('Not show');
                  } else if (snapshot.hasData) {
                    print('show');
                    return ListView.separated(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Color.fromRGBO(33, 33, 33, 0.08),
                        );
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () => ticketTap(snapshot.data[index]),
                          leading: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 100,
                              maxHeight: 56,
                            ),
                            child: Image.network(
                                snapshot.data[index].image.small,
                                fit: BoxFit.cover),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${snapshot.data[index].content}'),
                            ],
                          ),
                        );
                      },
                    );

                    //     Text('Has data');
                  }
                  return Text('Loading...');
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(Icons.add),
        backgroundColor: Color.fromRGBO(98, 0, 238, 1),
      ),
    );
  }
}
