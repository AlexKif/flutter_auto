import 'dart:io';

import 'package:auto/api/api.dart';
import 'package:auto/layouts/appBarLayout.dart';
import 'package:auto/routing/routingConstants.dart';
import 'package:auto/widgets/customTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateTicket extends StatefulWidget {
  final CustomTextFormField textField;

  CreateTicket({this.textField});

  @override
  _CreateTicketState createState() => _CreateTicketState();
}

Future<void> _showMyDialog(BuildContext context, String title, String content,
    [Function onPressed]) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(content),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('ПОНЯТНО',
                style: TextStyle(
                    color: Color.fromRGBO(98, 0, 238, 1), fontSize: 15)),
            onPressed: onPressed ??
                () {
                  Navigator.of(context).pop();
                },
          ),
        ],
      );
    },
  );
}

class _CreateTicketState extends State<CreateTicket> {
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = new FocusNode();
  TextEditingController phoneController = TextEditingController();
  bool validate = true;

  File _image;
  final picker = ImagePicker();

  String validatePhone(String value) {
    if (value == null || value.isEmpty) {
      setState(() {
        validate = false;
      });
      return 'Please enter text';
    }
    if (!validate) {
      setState(() {
        validate = true;
      });
    }
    return null;
  }

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void onFieldTap(BuildContext context) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  createTicketHandler(BuildContext context) {
    if (_formKey.currentState.validate()) {
      if (_image != null) {
        uploadImage(_image.path).then((res) {
          createNewTicket(phoneController.text, res.id).then((value) =>
              _showMyDialog(context, 'Успех!',
                  'Ваш запрос удачно создан. Продавец свяжется с вами в скором времени',
                  () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeViewRoute, (Route<dynamic> route) => false);
              }));
        });
      } else {
        _showMyDialog(
            context, 'Ошибка', 'Загрузите изображение для создания запроса');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: AppBarLayout(
            title: 'Новый запрос',
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight - 35,
                ),
                child: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFormField(
                                  controller: phoneController,
                                  focusNode: focusNode,
                                  onTap: onFieldTap,
                                  fieldType: TextInputType.multiline,
                                  textInputAction: TextInputAction.done,
                                  functionValidate: validatePhone,
                                  labelText: "Добавить описание",
                                  validate: validate),
                              if (_image != null)
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(top: 17),
                                    child: Image.file(
                                      _image,
                                      height: 274,
                                    )),
                              TextButton(
                                onPressed: getImage,
                                child: Text(
                                  'Добавить снимок',
                                  style: TextStyle(
                                      color: Color.fromRGBO(98, 0, 238, 1),
                                      fontSize: 17,
                                      fontFamily: 'RobotoMedium'),
                                ),
                              )
                            ],
                          )),
                      Flexible(
                        child: SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                primary: Color.fromRGBO(98, 0, 238, 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'СОЗДАТЬ ЗАПРОС',
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'RobotoMedium'),
                                )
                              ],
                            ),
                            onPressed: () => createTicketHandler(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
