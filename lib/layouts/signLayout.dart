import 'package:auto/helpers/ColorToHex.dart';
import 'package:auto/widgets/customTextFormField.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class SignLayout extends StatefulWidget {
  final double dotIndex;
  final String actionTextForUser;
  final CustomTextFormField textField;
  final FocusNode focusNode;
  final bool validate;
  final String value;
  final String name;
  final Function successValidation;
  final Function onTapSign;

  SignLayout({
    this.dotIndex,
    this.actionTextForUser,
    this.textField,
    this.name,
    this.validate,
    this.focusNode,
    this.onTapSign,
    this.value,
    this.successValidation,
  });

  @override
  _SignLayoutState createState() => _SignLayoutState();
}

class _SignLayoutState extends State<SignLayout> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
                top: 124,
                right: 17,
                left: 17,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight -
                    124 -
                    MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      if (!widget.focusNode.hasFocus)
                        Image(
                            width: 126,
                            image: AssetImage('assets/images/login-icon.jpg')),
                      SizedBox(height: 48),
                      Text(
                        '${widget.name == 'signIn' ? "??????????????" : "??????????????????????"}',
                        style:
                            TextStyle(fontSize: 34, fontFamily: "RobotoBold"),
                      ),
                      if (widget.focusNode.hasFocus)
                        Container(
                          padding: EdgeInsets.only(top: 16, bottom: 65),
                          child: Column(
                            children: [
                              Text(
                                widget.actionTextForUser,
                                style: TextStyle(
                                    color: Color.fromRGBO(60, 60, 67, .6),
                                    fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      if (!widget.focusNode.hasFocus) SizedBox(height: 24),
                      Form(key: _formKey, child: widget.textField),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  HexColor('#6200EE')),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.0),
                              ))),
                          child: Text(
                            '??????????',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'RobotoMedium'),
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState.validate()) {
                              widget.successValidation();
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 14),
                      DotsIndicator(
                        dotsCount: 2,
                        position: widget.dotIndex,
                        decorator: DotsDecorator(
                          color: HexColor('#B3B3B3'), // Inactive color
                          activeColor: Colors.black,
                        ),
                      ),
                      if (!widget.focusNode.hasFocus)
                        Column(
                          children: [
                            SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    '${widget.name == 'signIn' ? "?????? ?????? ?????????????????" : "?????? ???????? ???????????????"}',
                                    style: TextStyle(
                                        color: Color.fromRGBO(60, 60, 67, 0.6),
                                        fontSize: 15)),
                                TextButton(
                                  onPressed: () {
                                    widget.onTapSign(context);
                                  },
                                  child: Text(
                                    '${widget.name == 'signIn' ? "????????????????????????????????????" : "??????????????"}',
                                    style: TextStyle(
                                        color: HexColor('#007AFF'),
                                        fontSize: 15,
                                        fontFamily: 'RobotoBold'),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
