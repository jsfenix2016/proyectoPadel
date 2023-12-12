import 'package:flutter/material.dart';

import 'package:Klasspadel/Page/Home/Pageview/homeScreen.dart';
import 'package:Klasspadel/Page/Login/Pageview/loginScreen.dart';
import 'package:Klasspadel/Page/Onboarding/PageView/onboarding.dart';
import 'package:Klasspadel/Page/Register/Pageview/register_screen.dart';

final Map<String, WidgetBuilder> appRoute = {
  "onbording": (BuildContext context) => OnboardingPage(),
  "loginScreen": (BuildContext context) => const LoginScreen(),
  "registerScreen": (BuildContext context) => const RegisterScreen(),
  "homeScreen": (BuildContext context) => const HomePage(
        typeUser: "",
      ),
};
