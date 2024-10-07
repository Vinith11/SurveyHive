import 'package:flutter/material.dart';
import 'package:hackathon/survey/fillSurvey.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'authprovider.dart';
import 'profile.dart';
import 'analytic.dart';
import '../survey/surveylist.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StompClient? stompClient;

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  void _connectToWebSocket() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://7920-2401-4900-16eb-d724-cca2-20d1-6e30-daf9.ngrok-free.app/ws',
        onConnect: _onConnect,
        beforeConnect: () async {
          // Add JWT token in headers
          await Future.delayed(Duration(milliseconds: 200));
        },
        stompConnectHeaders: {'Authorization': 'Bearer ${authProvider.jwt}'},
        webSocketConnectHeaders: {'Authorization': 'Bearer ${authProvider.jwt}'},
      ),
    );

    stompClient!.activate();
  }

  void _onConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/topic/surveys',
      callback: (frame) {
        // Handle incoming survey data
        print(frame.body);
      },
    );
  }

  @override
  void dispose() {
    stompClient?.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/signin');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0,left: 20.0 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildSquareButton(
              context,
              'Create Surveys',
              'assets/images/survey_icon.jpeg',
              SurveyListScreen(),
              Colors.blue,
              imageHeight: 100,
              imageWidth: 200,
            ),
            SizedBox(height: 8),
            buildSquareButton(
              context,
              'Analytics',
              'assets/images/analytics_icon.png',
              AnalyticsScreen(),
              Colors.red,
              imageHeight: 100,
              imageWidth: 200,

            ),
            SizedBox(height: 8),
            buildSquareButton(
              context,
              'Fill Survey',
              'assets/images/fill_survey.jpg',
              FillSurveyScreen(),
              Colors.grey,
              imageHeight: 100,
              imageWidth: 200,
            ),
            SizedBox(height: 8),
            buildSquareButton(
              context,
              'Edit Profile',
              'assets/images/profile_icon.png',
              ProfileScreen(),
              Colors.green,
              imageHeight: 100,
              imageWidth: 200,
            ),
            // Add more buttons as needed
          ],
        ),
      ),
    );
  }

  Widget buildSquareButton(BuildContext context, String text, String imagePath, Widget screen, Color color, {double? imageHeight, double? imageWidth}) {
    return Container(
      height: 180, // Example height for the button container
      width: 180, // Example width for the button container
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  imagePath,
                  height: imageHeight ?? 100, // Default height if not specified
                  width: imageWidth ?? 100, // Default width if not specified
                  fit: BoxFit.contain, // Adjust the fit as needed
                ),
                SizedBox(height: 16),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
