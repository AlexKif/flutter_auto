import 'package:auto/api/api.dart';
import 'package:auto/helpers/ColorToHex.dart';
import 'package:auto/layouts/appBarLayout.dart';
import 'package:auto/models/user/userForms.dart';
import 'package:auto/routing/arguments.dart';
import 'package:auto/routing/routingConstants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CatalogHomeView extends StatefulWidget {
  @override
  _CatalogHomeViewState createState() => _CatalogHomeViewState();
}

class _CatalogHomeViewState extends State<CatalogHomeView> {
  Future<List<UserForms>> formsData;

  List<Widget> skeletonItems = List.generate(
      7,
      (index) => Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey,
                    width: 100,
                    height: 56,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ));

  @override
  void initState() {
    formsData = getForms();
    super.initState();
  }

  void ticketTap(BuildContext context, UserForms ticket) {
    Navigator.pushNamed(context, TicketViewRoute,
        arguments: TicketArguments(ticket: ticket));
  }

  void createTicket(BuildContext context) {
    Navigator.pushNamed(context, CreateTicketViewRoute);
  }

  Future<void> _onRefresh() async {
    setState(() {
      formsData = getForms();
    });
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
                future: formsData,
                builder: (context, snapshot) {
                  if (snapshot.hasError &&
                      snapshot.connectionState == ConnectionState.none) {
                    print('not show');
                    logout();
                    return Text('Not show');
                  } else if (snapshot.hasData) {
                    print('show');
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.separated(
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
                            onTap: () =>
                                ticketTap(context, snapshot.data[index]),
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
                      ),
                    );

                    //     Text('Has data');
                  }
                  return Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Shimmer.fromColors(
                      baseColor: HexColor('FFD5D3D3'),
                      highlightColor: HexColor('FFF1F1F1'),
                      child: Column(
                        children: skeletonItems,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createTicket(context),
        child: const Icon(Icons.add),
        backgroundColor: Color.fromRGBO(98, 0, 238, 1),
      ),
    );
  }
}
