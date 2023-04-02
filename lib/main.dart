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
  late Future<Doctor> doctorFuture; // = getDataFromAPI();
  Doctor doctor = Doctor(
      id: "0",
      doctorNameAR: "",
      doctorNameEN: "",
      roomID: 0,
      clinicNameAR: "",
      clinicNameEN: "",
      specialtyAR: "",
      specialtyEN: "",
      clinicStartDate: "2023-01-01 00:00:00",
      clinicEndDate: "2023-01-01 00:00:00",
      imagePath: "http://ahj-queue.andalusiagroup.net:1020/api/getEmptyImage",
      refreshImage: false,
      displayTime: false,
      isActive: false);
  var secondDateTime = DateTime.now().millisecondsSinceEpoch.toString();
  var mainURL = "";
  DateTime? firstPressedTime;
  int durationSeconds = 60;
  bool isTimeDisplay = true;
  bool isImageDisplay = true;
  Config config = Config(
      duration: "10",
      doctorNameENTop: "170",
      doctorNameENFontSize: "70",
      doctorNameARTop: "10",
      doctorNameARFontSize: "70",
      specialtyENTop: "50",
      specialtyENFontSize: "70",
      specialtyENFontColorRed: "255",
      specialtyENFontColorGreen: "153",
      specialtyENFontColorBlue: "0",
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
      doctorFuture = Future.value(doctor);
      Timer.periodic(Duration(seconds: int.parse(config.duration)), (timer) {
        setState(() {
          secondDateTime = DateTime.now().millisecondsSinceEpoch.toString();
          getDataFromAPI().then((value) {
            if (value.doctorNameEN != doctor.doctorNameEN) {
              doctor = value;
              doctorFuture = Future.value(value);
            }
          }).catchError((err) {
            print(err);
          });
          getConfigurationFromAPI().then((value) {
            config = value;
          });
        });
      });
    });
  }

  Future<Config> getConfigurationFromAPI() async {
    String url =
        "http://ahj-queue.andalusiagroup.net:1020/api/getConfiguration/";
    final response1 = await http.get(Uri.parse(url));
    Config config1;
    var completer = Completer<Config>();
    if (response1.statusCode == 200) {
      config1 = Config.fromJson(jsonDecode(response1.body));
      completer.complete(config1);
    }

    return completer.future;
  }

  Future<Doctor> getDataFromAPI() async {
    String url =
        "http://ahj-queue.andalusiagroup.net:1020/api/getClinicByIPAddress/device";
    final response2 = await http.get(Uri.parse(url));
    if (response2.statusCode == 200) {
      if (response2.body != "") {
        var doctor = Doctor.fromJson(jsonDecode(response2.body));
        var completer = Completer<Doctor>();
        completer.complete(doctor);
        return completer.future;
      } else {
        var completer = Completer<Doctor>();
        completer.complete(Doctor(
            id: "0",
            doctorNameAR: "",
            doctorNameEN: "",
            roomID: 0,
            clinicNameAR: "",
            clinicNameEN: "",
            specialtyAR: "",
            specialtyEN: "",
            clinicStartDate: "2023-01-01 00:00:00",
            clinicEndDate: "2023-01-01 00:00:00",
            imagePath:
                "http://ahj-queue.andalusiagroup.net:1020/api/getEmptyImage",
            refreshImage: false,
            displayTime: false,
            isActive: false));
        return completer.future;
      }
      // return Doctor.fromJson(jsonDecode(response2.body));
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
      body: FutureBuilder<Doctor>(
        future: doctorFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView(
              children: const [
                Text('Pleas wait, Data is loading...'),
              ],
            );
          } else {
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
              DateTime startDate =
                  DateTime.parse(snapshot.data!.clinicStartDate);
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
                                color: Color.fromARGB(
                                    255,
                                    int.parse(config.specialtyENFontColorRed),
                                    int.parse(config.specialtyENFontColorGreen),
                                    int.parse(config.specialtyENFontColorBlue)),
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
                                fontSize:
                                    double.parse(config.clinicDateFontSize),
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
                  Text('Pleas wait, Data is loading...'),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
