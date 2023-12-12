import 'dart:ffi';

import 'package:Klasspadel/Common/decoder_custom.dart';
import 'package:Klasspadel/Page/Onboarding/PageView/Widgets/widgets_page_model.dart';
import 'package:flutter/material.dart';
import 'package:Klasspadel/Common/preferer_user.dart';
import 'package:Klasspadel/Page/Login/Pageview/loginScreen.dart';
import 'package:onboarding/onboarding.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});
  final PreferenceUser _prefs = PreferenceUser();
  final onboardingPagesList = [
    PageModel(
      widget: const PageModalCustomBody(
        urlImg: 'assets/images/onboarding1.png',
        title: 'Mejora tú juego',
        textDescription: 'Ahora es posible entrenar y grabar tus movimientos',
      ),
    ),
    PageModel(
      widget: const PageModalCustomBody(
        urlImg: 'assets/images/onboarding2.png',
        title: '¿Mala postura?',
        textDescription:
            'Aquí podras pedir ayuda  para conseguir mejorar mas rapido.',
      ),
    ),
    PageModel(
      widget: const PageModalCustomBody(
        urlImg: 'assets/images/onboarding3.png',
        title: '¿Quieres ayudar a mejorar las tecnicas?',
        textDescription: 'Aqui podras conseguirlo',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0, 1),
            colors: <Color>[
              Colors.black,
              Colors.black,
              Colors.black,
            ],
            tileMode: TileMode.mirror,
          ),
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Colors.yellow,
                blurRadius: 3.0,
                offset: Offset(0.0, 5.0),
                spreadRadius: 3.0),
          ],
        ),
        child: Onboarding(
          background: Colors.black,
          proceedButtonStyle: ProceedButtonStyle(
            proceedButtonColor:
                const Color.fromARGB(255, 33, 33, 33).withAlpha(300),
            proceedpButtonText: const Text(
              "Continuar",
              style: TextStyle(fontSize: 16, color: Colors.yellow),
            ),
            proceedButtonRoute: (context) {
              _prefs.onboarding = false;
              return Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          pages: onboardingPagesList,
          isSkippable: false,
          indicator: Indicator(
            closedIndicator:
                const ClosedIndicator(color: Colors.yellow, borderWidth: 0.7),
            activeIndicator:
                const ActiveIndicator(color: Colors.grey, borderWidth: 0.7),
            indicatorDesign: IndicatorDesign.polygon(
              polygonDesign: PolygonDesign(
                polygon: DesignType.polygon_circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
