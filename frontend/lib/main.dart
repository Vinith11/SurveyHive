import 'package:flutter/material.dart';
import 'package:hackathon/pages/authprovider.dart';
import 'package:hackathon/pages/home.dart';
import 'package:hackathon/pages/signin.dart';
import 'package:hackathon/pages/signup.dart';
import 'package:hackathon/splashScreen.dart';
import 'package:hackathon/survey/surveyprovider.dart';
import 'package:provider/provider.dart';
import 'package:hackathon/survey/surveyScreen.dart';
import 'package:hackathon/survey/surveylist.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => SurveyProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Survey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (auth.jwt == null) {
            return SplashScreen();
          } else {
            return HomePage();
          }
        },

      ),


      routes: {
        '/signin': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/survey_list': (context) => SurveyListScreen(),
        // '/survey_form': (context) => SurveyFormScreen(survey: ),
        '/surveys': (context) => SurveyScreen(),

      },

    );
  }
}
