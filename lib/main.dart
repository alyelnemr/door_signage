import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';

import 'config.dart';
import 'doctor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Doctor> doctorsList = getDataFromAPI();
  var secondDateTime = DateTime.now().millisecondsSinceEpoch.toString();
  var mainURL = "";
  DateTime? firstPressedTime;
  int durationSeconds = 60;
  bool isTimeDisplay = true;
  bool isImageDisplay = true;
  Config config = Config(
      duration: "120",
      doctorNameENTop: "170",
      doctorNameENFontSize: "70",
      doctorNameARTop: "10",
      doctorNameARFontSize: "70",
      specialtyENTop: "50",
      specialtyENFontSize: "70",
      specialtyARTop: "10",
      specialtyARFontSize: "70",
      clinicDateTop: "60",
      clinicDateFontSize: "70");

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    setState(() {
      secondDateTime = DateTime.now().millisecondsSinceEpoch.toString();
      getConfigurationFromAPI().then((value) {
        config = value;
        Timer.periodic(Duration(seconds: int.parse(config.duration)), (timer) {
          setState(() {
            secondDateTime = DateTime.now().millisecondsSinceEpoch.toString();
            doctorsList = getDataFromAPI();
            print('doctorsList: $doctorsList');
          });
        });
      });
    });
  }

  Future<Config> getConfigurationFromAPI() async {
    String url =
        "http://ahj-queue.andalusiagroup.net:1020/api/getConfiguration/";
    // String url = "http://ahj-queue-01/api/getConfiguration/";
    final response1 = await http.get(Uri.parse(url));
    if (response1.statusCode == 200) {
      config = Config.fromJson(jsonDecode(response1.body));
    }

    var completer = Completer<Config>();
    completer.complete(config);
    return completer.future;
  }

  Future<Doctor> getDataFromAPI() async {
    String url =
        "http://ahj-queue.andalusiagroup.net:1020/api/getClinicByIPAddress/device";
    final response2 = await http.get(Uri.parse(url));
    if (response2.statusCode == 200) {
      return Doctor.fromJson(jsonDecode(response2.body));
    } else {
      throw Exception("Error in calling api");
    }
  }

  String formatClinicDate(DateTime currentDate) {
    if (isTimeDisplay) {
      return DateFormat('hh:mm a').format(currentDate);
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<Doctor>(
        future: doctorsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String doctorNameEN =
                snapshot.data!.isActive ? snapshot.data!.doctorNameEN : "";
            String doctorNameAR =
                snapshot.data!.isActive ? snapshot.data!.doctorNameAR : "";
            // String clinicNameAR = snapshot.data!.isActive ? snapshot.data!.clinicNameAR : "";
            // String clinicNameEN = snapshot.data!.isActive ? snapshot.data!.clinicNameEN : "";
            String specialtyAR =
                snapshot.data!.isActive ? snapshot.data!.specialtyAR : "";
            String specialtyEN =
                snapshot.data!.isActive ? snapshot.data!.specialtyEN : "";
            isImageDisplay = snapshot.data!.refreshImage;
            isTimeDisplay = snapshot.data!.displayTime;
            mainURL = snapshot.data!.imagePath;
            if (isImageDisplay) {
              mainURL = "${snapshot.data!.imagePath}?dum=$secondDateTime";
            }
            DateTime startDate = DateTime.parse(snapshot.data!.clinicStartDate);
            DateTime endDate = DateTime.parse(snapshot.data!.clinicEndDate);
            String stringClinicDateTime = snapshot.data!.isActive
                ? '${formatClinicDate(startDate)} - ${formatClinicDate(endDate)}'
                : "";
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(mainURL), fit: BoxFit.cover),
              ),
              child: ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: double.parse(config.doctorNameENTop)),
                      child: Text(doctorNameEN,
                          style: TextStyle(
                              fontSize:
                                  double.parse(config.doctorNameENFontSize),
                              fontFamily: "Avenir Black")),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: double.parse(config.doctorNameARTop)),
                      child: Text(doctorNameAR,
                          style: TextStyle(
                              fontSize:
                                  double.parse(config.doctorNameARFontSize),
                              fontFamily: "Avenir Black")),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: double.parse(config.specialtyENTop)),
                      child: Text(specialtyEN,
                          style: TextStyle(
                              fontSize:
                                  double.parse(config.specialtyENFontSize),
                              fontFamily: "Avenir Black")),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: double.parse(config.specialtyARTop)),
                      child: Text(specialtyAR,
                          style: TextStyle(
                              fontSize:
                                  double.parse(config.specialtyARFontSize),
                              fontFamily: "Avenir Black")),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: double.parse(config.clinicDateTop)),
                      child: Text(stringClinicDateTime,
                          style: TextStyle(
                              fontSize: double.parse(config.clinicDateFontSize),
                              fontFamily: "Avenir Black")),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return ListView(
              children: [
                Text('url: $mainURL'),
                Text('Error: ${snapshot.error}')
              ],
            );
          } else {
            return ListView(
              children: const [
                Text('No Data to be displayed...'),
              ],
            );
          }
        },
      ),
    );
  }
}
