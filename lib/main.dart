import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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

  @override
  void initState(){
    super.initState();
    Timer.periodic(const Duration(seconds: 20), (timer) {
      setState(() {
        secondDateTime = DateTime.now().millisecondsSinceEpoch.toString();
        doctorsList = getDataFromAPI();
        print('2 minutes passed');
      });
    });
  }

   Future<Doctor> getDataFromAPI() async {
    String clinicIPAddress = "device";
    String url = "http://10.102.111.30:1020/api/getClinicByIPAddress/$clinicIPAddress";
    final response = await http.get(Uri.parse(url));
    print('url $url');
    if (response.statusCode == 200) {
      print('response.body ${response.body}');
      return Doctor.fromJson_(jsonDecode(response.body));
    } else {
      throw Exception("Error in calling api");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child:
        Center(
          child: FutureBuilder<Doctor>(
            future: doctorsList,
            builder: (context, snapshot){

              if(snapshot.hasData) {
                mainURL = "${snapshot.data!.imagePath}?dum=$secondDateTime";
                print("snapshot.data!.imagePath $mainURL");
                return Image.network(mainURL);
              } else if (snapshot.hasError) {
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
          ),
        ),
    );
  }
}
