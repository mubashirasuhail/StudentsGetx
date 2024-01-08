import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentsgetx/controller/student_controller.dart';
import 'package:studentsgetx/splash.dart';

const SAVE_KEY = 'UserLoggedin';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize StudentController
  await Get.putAsync<StudentController>(() async => StudentController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Student Record',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // Add more theme properties if needed
      ),
      home: Splashscreen(),
    );
  }
}
