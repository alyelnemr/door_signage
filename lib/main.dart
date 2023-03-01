import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';

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


  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    Timer.periodic(const Duration(seconds: 20), (timer) {
      setState(() {
        secondDateTime = DateTime.now().millisecondsSinceEpoch.toString();
        doctorsList = getDataFromAPI();
        print('doctorsList: ' + doctorsList.toString());
      });
    });
  }

   Future<Doctor> getDataFromAPI() async {
    String clinicIPAddress = "device";
    String url = "http://10.102.111.30:1020/api/getClinicByIPAddress/device";
    final response = await http.get(Uri.parse(url));
    print('url $url');
    if (response.statusCode == 200) {
      print('response.body ${response.body}');
      return Doctor.fromJson_(jsonDecode(response.body));
    } else {
      throw Exception("Error in calling api");
    }
  }

  String formatClinicDate(DateTime currentDate){
    return DateFormat('hh:mm a').format(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<Doctor>(
        future: doctorsList,
        builder: (context, snapshot){
          if(snapshot.hasData) {
            mainURL = "${snapshot.data!.imagePath}?dum=$secondDateTime";
            String doctorNameEN = snapshot.data!.doctorNameEN;
            String doctorNameAR = snapshot.data!.doctorNameAR;
            String clinicNameAR = snapshot.data!.clinicNameAR;
            String clinicNameEN = snapshot.data!.clinicNameEN;
            String specialtyAR = snapshot.data!.specialtyAR;
            String specialtyEN = snapshot.data!.specialtyEN;
            DateTime startDate = DateTime.parse(snapshot.data!.clinicStartDate);
            DateTime endDate = DateTime.parse(snapshot.data!.clinicEndDate);
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(mainURL),
                    fit: BoxFit.cover
                ),
              ),
              child: ListView(
                children: [
                  Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 220),
                    child: Text(doctorNameEN, style: const TextStyle(fontSize: 70)),
                  ),
                ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(doctorNameAR, style: const TextStyle(fontSize: 70)),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(specialtyEN, style: const TextStyle(fontSize: 50)),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(specialtyAR, style: const TextStyle(fontSize: 50)),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text('${formatClinicDate(startDate)} - ${formatClinicDate(endDate)}', style: const TextStyle(fontSize: 40)),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
             print(snapshot.stackTrace);
            return ListView(
              children: [
                Text('url: $mainURL'),
                Text('Error: ${snapshot.error}')
              ],
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

}
