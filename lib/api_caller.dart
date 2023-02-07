import 'package:door_signage/doctor.dart';
import 'package:http/http.dart' as http;

class APICaller {
  Future<List<Doctor>?> getDoctorList() async {
    var client = http.Client();
    
    var uri = Uri.parse("http://localhost:1000/db/test22");

    return null;
  }
}