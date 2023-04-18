import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:door_signage/preferences.dart';
import 'package:door_signage/queue.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:core';

import 'config.dart';
import 'doctor.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MyPreferences.init();

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
  late Future<QueueData> queueDataFuture;
  double? downloadProgress;
  String ipAddress = "";
  List<bool> listDeviceType = [false, false]; // OPD or IPD
  String upgradeURL = "http://ahj-queue.andalusiagroup.net:1020/api/getUpdate/";
  QueueData queueData = QueueData(queueText: "");
  late TextEditingController passwordController;
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
      isActive: false,
      isIPD: false);
  var secondDateTime = DateTime.now().millisecondsSinceEpoch.toString();
  var mainURL = "";
  DateTime? firstPressedTime;
  int durationSeconds = 10;
  bool isTimeDisplay = true;
  bool isImageDisplay = true;
  bool isIPD = false;
  Config config = Config(
      duration: "10",
      durationIPD: "3600",
      appPassword: "1234",
      doctorNameENTop: "170",
      doctorNameENTopIPD: "70",
      doctorNameENFontSize: "70",
      doctorNameARTop: "10",
      doctorNameARFontSize: "70",
      specialtyENTop: "50",
      specialtyENFontSize: "70",
      specialtyENFontColorRed: "255",
      specialtyENFontColorGreen: "153",
      specialtyENFontColorBlue: "0",
      specialtyARTop: "10",
      specialtyARTopIPD: "50",
      specialtyARFontSize: "70",
      clinicDateTop: "60",
      clinicDateFontSize: "70");

  @override
  void initState() {
    super.initState();

    isIPD = MyPreferences.getDeviceTypeIsIPD() ?? false;
    if (isIPD == false) {
      listDeviceType[0] = true;
      listDeviceType[1] = false;
      doctor.imagePath =
          "http://ahj-queue.andalusiagroup.net:1020/api/getEmptyImage";
    } else {
      listDeviceType[0] = false;
      listDeviceType[1] = true;
      doctor.imagePath =
          "http://ahj-queue.andalusiagroup.net:1020/api/getEmptyImageIPD";
    }

    passwordController = TextEditingController();
    getIPAddressFromAPI().then((value) {
      setState(() {
        ipAddress = value;
      });
    });
    getConfigurationFromAPI().then((value) {
      setState(() {
        config = value;
      });
    });
    getDataFromAPI().then((value) {
      setState(() {
        doctor = value;
        doctorFuture = Future.value(value);
        if (isIPD != doctor.isIPD) {
          isIPD = doctor.isIPD;
          MyPreferences.setDeviceTypeIsIPD(isIPD);
        }
      });
    });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    setState(() {
      secondDateTime = DateTime.now().millisecondsSinceEpoch.toString();
      queueDataFuture = Future.value(queueData);
      doctorFuture = Future.value(doctor);
    });
    Timer.periodic(
        Duration(
            seconds: int.parse(isIPD ? config.durationIPD : config.duration)),
        (timer) {
      setState(() {
        secondDateTime = DateTime.now().millisecondsSinceEpoch.toString();
      });
      getDataFromAPI().then((value) {
        setState(() {
          doctor = value;
          doctorFuture = Future.value(value);
          if (isIPD != doctor.isIPD) {
            isIPD = doctor.isIPD;
            MyPreferences.setDeviceTypeIsIPD(isIPD);
          }

          if (isIPD == false) {
            queueDataFuture =
                Future.value(QueueData(queueText: value.specialtyEN));
          }
        });
      }).catchError((err) {
        print(err);
      });
    });
    Timer.periodic(const Duration(hours: 1), (timer) {
      getConfigurationFromAPI().then((value) {
        setState(() {
          config = value;
        });
      });
    });
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
        Doctor doc = Doctor(
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
            isActive: false,
            isIPD: false);
        if (isIPD) {
          doc.imagePath =
              "http://ahj-queue.andalusiagroup.net:1020/api/getEmptyImageIPD";
        }
        completer.complete(doc);
        return completer.future;
      }
      // return Doctor.fromJson(jsonDecode(response2.body));
    } else {
      throw Exception("Error in calling api");
    }
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

  Future<String> getIPAddressFromAPI() async {
    String url = "http://ahj-queue.andalusiagroup.net:1020/api/getIP/";
    final response1 = await http.get(Uri.parse(url));
    String ip;
    var completer = Completer<String>();
    if (response1.statusCode == 200) {
      ip = response1.body;
      completer.complete(ip);
    }
    return completer.future;
  }

  Future<void> onPressedGoodPassword() async {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Please Select"),
          children: [
            SimpleDialogOption(
              child: const Text(
                "Refresh All Data",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                getDataFromAPI().then((value) {
                  setState(() {
                    doctor = value;
                    doctorFuture = Future.value(value);
                    if (isIPD != doctor.isIPD) {
                      isIPD = doctor.isIPD;
                      MyPreferences.setDeviceTypeIsIPD(isIPD);
                    }
                  });
                });
              },
            ),
            SimpleDialogOption(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Device Type",
                    style: TextStyle(fontSize: 20),
                  ),
                  StatefulBuilder(builder: (context, setState) {
                    return Container(
                      color: Colors.amber.shade50,
                      child: ToggleButtons(
                        onPressed: (int newIndex) {
                          setState(() {
                            for (int i = 0; i < listDeviceType.length; i++) {
                              if (i == newIndex) {
                                listDeviceType[i] = true;
                              } else {
                                listDeviceType[i] = false;
                              }
                            }
                            if (listDeviceType[0] == true) {
                              MyPreferences.setDeviceTypeIsIPD(false);
                              isIPD = false;
                            } else {
                              MyPreferences.setDeviceTypeIsIPD(true);
                              isIPD = true;
                            }
                          });
                        },
                        isSelected: listDeviceType,
                        color: Colors.amber,
                        selectedColor: Colors.white,
                        fillColor: Colors.amber.shade700,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              "OPD",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              "IPD",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            SimpleDialogOption(
              child: const Text(
                "Show IP Address",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: const Text("IP Address"),
                        children: [
                          Center(
                              child: Text(
                            ipAddress,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                        ],
                      );
                    });
              },
            ),
            SimpleDialogOption(
              child: const Text(
                "Download and Install App Update",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                openAndDownloadFile();
              },
            ),
          ],
        );
      },
    );
  }

  void checkPassword() {
    getConfigurationFromAPI().then((value) {
      setState(() {
        config = value;
      });
    });
    if (passwordController.text == config.appPassword) {
      onPressedGoodPassword();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Wrong Password"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("  OK  "))
            ],
          );
        },
      );
    }
    passwordController.clear();
  }

  String formatClinicDate(DateTime currentDate) {
    if (isTimeDisplay) {
      return DateFormat('hh:mm a').format(currentDate);
    }
    return "";
  }

  Widget drawWidgetForQueue() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: double.parse(config.specialtyENTop)),
        child: FutureBuilder<QueueData>(
          future: queueDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(snapshot.data!.queueText,
                  style: TextStyle(
                      color: Color.fromARGB(
                          255,
                          int.parse(config.specialtyENFontColorRed),
                          int.parse(config.specialtyENFontColorGreen),
                          int.parse(config.specialtyENFontColorBlue)),
                      fontSize: double.parse(config.specialtyENFontSize),
                      fontFamily: "Avenir Black"));
            } else {
              return snapshot.data == null
                  ? const Text("")
                  : Text(snapshot.data!.queueText,
                      style: TextStyle(
                          color: Color.fromARGB(
                              255,
                              int.parse(config.specialtyENFontColorRed),
                              int.parse(config.specialtyENFontColorGreen),
                              int.parse(config.specialtyENFontColorBlue)),
                          fontSize: double.parse(config.specialtyENFontSize),
                          fontFamily: "Avenir Black"));
            }
          },
        ),
      ),
    );
  }

  void onPressedFloating() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Password"),
          content: TextField(
            controller: passwordController,
            keyboardType: TextInputType.number,
            autofocus: true,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          actions: [
            TextButton(onPressed: checkPassword, child: const Text("  OK  "))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: onPressedFloating,
          backgroundColor: Colors.amber,
          child: const Icon(Icons.medication, color: Colors.white),
        ),
        body: FutureBuilder<Doctor>(
          future: doctorFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
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
                        child: Text("Data is loading.....",
                            style: TextStyle(
                                fontSize:
                                    double.parse(config.doctorNameENFontSize),
                                fontFamily: "Avenir Black")),
                      ),
                    ),
                  ],
                ),
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
                isImageDisplay = snapshot.data!.refreshImage;
                isTimeDisplay = snapshot.data!.displayTime;
                mainURL = snapshot.data!.imagePath;
                if (isImageDisplay) {
                  mainURL = "${snapshot.data!.imagePath}?dum=$secondDateTime";
                }
                DateTime startDate =
                    DateTime.parse(snapshot.data!.clinicStartDate);
                DateTime endDate = DateTime.parse(snapshot.data!.clinicEndDate);
                String stringClinicDateTime = isIPD
                    ? ""
                    : isTimeDisplay
                        ? snapshot.data!.isActive
                            ? '${formatClinicDate(startDate)} - ${formatClinicDate(endDate)}'
                            : ""
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
                              top: double.parse(isIPD
                                  ? config.doctorNameENTopIPD
                                  : config.doctorNameENTop)),
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
                      isIPD ? const Text("") : drawWidgetForQueue(),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: double.parse(isIPD
                                  ? config.specialtyARTopIPD
                                  : config.specialtyARTop)),
                          child: Text(specialtyAR,
                              style: TextStyle(
                                  fontSize:
                                      double.parse(config.specialtyARFontSize),
                                  fontFamily: "Avenir Black")),
                        ),
                      ),
                      isIPD
                          ? const Text("")
                          : Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: double.parse(config.clinicDateTop)),
                                child: Text(stringClinicDateTime,
                                    style: TextStyle(
                                        fontSize: double.parse(
                                            config.clinicDateFontSize),
                                        fontFamily: "Avenir Black")),
                              ),
                            ),
                      isIPD
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: double.parse(config.clinicDateTop)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(mainURL),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row()
                                  ],
                                ),
                              ),
                            )
                          : const Text(""),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
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
                          child: snapshot.error == null
                              ? Text("Error Occurred",
                                  style: TextStyle(
                                      fontSize: double.parse(
                                          config.doctorNameENFontSize),
                                      fontFamily: "Avenir Black"))
                              : Text(snapshot.error.toString(),
                                  style: TextStyle(
                                      fontSize: double.parse(
                                          config.doctorNameENFontSize),
                                      fontFamily: "Avenir Black")),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
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
                          child: Text("Data is loading.....",
                              style: TextStyle(
                                  fontSize:
                                      double.parse(config.doctorNameENFontSize),
                                  fontFamily: "Avenir Black")),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Future<bool> onWillPop(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Password to exit App"),
          content: TextField(
            controller: passwordController,
            keyboardType: TextInputType.number,
            autofocus: true,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          actions: [
            TextButton(
                onPressed: checkPasswordForExit, child: const Text("  OK  "))
          ],
        );
      },
    );
    return exitApp;
  }

  void checkPasswordForExit() {
    if (passwordController.text == config.appPassword) {
      Navigator.of(context).pop(true);
    } else {
      Navigator.of(context).pop(false);
    }
    passwordController.clear();
  }

  Future openAndDownloadFile() async {
    final file = await downloadFile();
    if (file == null) return;
    print('Path: ${file.path}');
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile() async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      String fileName =
          "door_signage${DateFormat('yy-mm-dd').format(DateTime.now())}.apk";
      print("app storage path ..${appStorage.path}.....");
      final file = File('${appStorage.path}/$fileName');
      final response = await Dio().get(
        upgradeURL,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: null,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      print("writing on file.....");
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }
}
