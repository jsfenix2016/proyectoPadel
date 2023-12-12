import 'package:Klasspadel/Common/Utils/util.dart';
import 'package:Klasspadel/Page/Loading/loading_screen.dart';
import 'package:Klasspadel/WidgetsCustom/checkbox_custom.dart';
import 'package:Klasspadel/WidgetsCustom/loading_custom.dart';
import 'package:Klasspadel/WidgetsCustom/logo_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:Klasspadel/Models/register_model.dart';
import 'package:Klasspadel/Models/rol_model.dart';
import 'package:Klasspadel/Page/Register/Controller/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerVC = Get.put(RegisterController());
  late UserRegisterModel userRegisterModel;
  late RolModel rolModel;

  String confirmPass = "";
  bool terms = false;
  List<RolModel> listTypeUser = [];
  bool alumno = false;
  bool choach = false;
  bool fisical = false;

  @override
  void initState() {
    userRegisterModel =
        UserRegisterModel(email: "", pass: "", terms: false, typeUser: "");

    super.initState();
  }

  void initPreference() async {}

  List<RolModel> selectTypeUser() {
    if (alumno) {
      listTypeUser.add(RolModel(idRol: 0));
    }
    if (choach) {
      listTypeUser.add(RolModel(idRol: 1));
    }
    if (fisical) {
      listTypeUser.add(RolModel(idRol: 2));
    }

    return listTypeUser;
  }

  // Widget switchCustom(
  //     bool valueType, String title, ValueChanged<bool> onChanged) {
  //   return Container(
  //     height: 40,
  //     color: Colors.transparent,
  //     child: CheckboxListTile(
  //       value: valueType,
  //       onChanged: (value) {
  //         onChanged(value!);
  //       },
  //       title: Text(
  //         title.tr,
  //         textAlign: TextAlign.left,
  //         style: styleCustomGoodTimes(),
  //       ),
  //     ),
  //   );
  // }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Center(child: LoadingCustom()),
        );
      },
    );
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  bool isloading = false;
  String typeUser = "Player";
  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      isLoading: isloading,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const LogoCustomApp(),
                  Container(
                    width: 350,
                    height: 450,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3.0,
                            offset: Offset(0.0, 5.0),
                            spreadRadius: 3.0),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Registro'.tr,
                          style: const TextStyle(
                            fontFamily: 'GoodTimes',
                            fontSize: 18.0,
                            wordSpacing: 1,
                            letterSpacing: 0.001,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        createTxt("Email", (onsave) {
                          userRegisterModel.email = onsave;
                          setState(() {});
                        }, (onchange) {
                          userRegisterModel.email = onchange;
                          setState(() {});
                        }),
                        const SizedBox(height: 5),
                        createTxt("Pass", (onsave) {
                          userRegisterModel.pass = onsave;
                          setState(() {});
                        }, (onchange) {
                          userRegisterModel.pass = onchange;
                          setState(() {});
                        }),
                        const SizedBox(height: 10),
                        // Column(
                        //   mainAxisSize: MainAxisSize.max,
                        //   children: [
                        //     const SizedBox(height: 10),
                        //     Text(
                        //       'typeUser'.tr,
                        //       style: styleCustomGoodTimesBold(),
                        //     ),
                        //     const SizedBox(height: 10),
                        //   ],
                        // ),
                        // CheckBoxCustom(
                        //     valueType: alumno,
                        //     title: "player",
                        //     onChanged: (value) {
                        //       alumno = value;
                        //       listTypeUser.add(RolModel(idRol: 0));

                        //       setState(() {});
                        //     }),
                        RadioListTile(
                          title: const Text("Player"),
                          value: "Player",
                          groupValue: typeUser,
                          onChanged: (value) {
                            setState(() {
                              typeUser = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text("Coach"),
                          value: "Coach",
                          groupValue: typeUser,
                          onChanged: (value) {
                            setState(() {
                              typeUser = value.toString();
                            });
                          },
                        ),
                        // CheckBoxCustom(
                        //     valueType: choach,
                        //     title: "coach",
                        //     onChanged: (value) {
                        //       choach = value;
                        //       listTypeUser.add(RolModel(idRol: 1));

                        //       setState(() {});
                        //     }),
                        CheckBoxCustom(
                          valueType: terms,
                          title: "Terminos y condiciones",
                          onChanged: (value) {
                            terms = value;
                            userRegisterModel.terms = terms;
                            setState(() {});
                          },
                          styleCustom: styleCustomGoodTimes(),
                          unselectedColorCustom: Colors.black,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent,
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.transparent,
                                ),
                              ),
                              onPressed: (() async {
                                // _onLoading();
                                setState(() {
                                  isloading = true;
                                });
                                if (!terms) {
                                  return;
                                }
                                if (userRegisterModel.pass.isEmpty) {
                                  return;
                                }
                                if (userRegisterModel.email.isEmpty) {
                                  return;
                                }
                                if (userRegisterModel.pass.isNotEmpty &&
                                    userRegisterModel.email.isNotEmpty &&
                                    terms) {
                                  userRegisterModel.typeUser = typeUser;
                                  bool continuePage =
                                      await registerVC.saveRegisterUser(
                                          context, userRegisterModel);

                                  if (continuePage) {
                                    setState(() {
                                      isloading = false;
                                      registerVC.goToLogin();
                                    });
                                  } else {
                                    setState(() {
                                      isloading = false;
                                    });
                                  }
                                }
                              }),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                ),
                                height: 40,
                                width: 250,
                                child: Center(
                                  child: Text(
                                    'register'.tr,
                                    style: styleCustomGoodTimesBold(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createTxt(String txt, ValueChanged<String> onSaved,
      ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Center(
        child: TextFormField(
          onChanged: onChanged,
          style: styleCustomGoodTimes(),
          key: Key(txt),
          initialValue: "",
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: styleCustomGoodTimes(),
            hintText: "",
            labelText: txt.tr,
            labelStyle: styleCustomGoodTimes(),
          ),
          onSaved: (value) => onSaved,
          validator: (value) {
            return txt.tr;
          },
        ),
      ),
    );
  }
}
