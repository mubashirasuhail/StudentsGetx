import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:studentsgetx/datamodel.dart';
import 'package:studentsgetx/controller/student_controller.dart';
import 'package:studentsgetx/home.dart'; // Import the StudentController

class Createscreen extends StatefulWidget {
  const Createscreen({Key? key}) : super(key: key);

  @override
  _CreatescreenState createState() => _CreatescreenState();
}

class _CreatescreenState extends State<Createscreen> {
  final name1controller = TextEditingController();
  final age1controller = TextEditingController();
  final div1controller = TextEditingController();
  String _selectedImagePath = '';
  final rollno1controller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Student')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    controller: name1controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Student Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Value is empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                TextFormField(
                  controller: age1controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Age',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: div1controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Class',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: rollno1controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Roll no',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Value is empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      onAddbutton();
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Data saved'),
                          content:
                              const Text('Student data saved successfully'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.offAll(() =>
                                    Homescreen());
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {}
                  },
                  child: const Text('Add Student'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  Future<void> onAddbutton() async {
    final _name = name1controller.text.trim();
    final _age = age1controller.text.trim();
    final _div = div1controller.text.trim();
    final _rollno = rollno1controller.text.trim();
    if (_name.isEmpty || _age.isEmpty || _div.isEmpty || _rollno.isEmpty) {
      return;
    }

    final student = StudentModel(
        name: _name,
        age: _age,
        div: _div,
        rollno: _rollno,
        imagepath: _selectedImagePath);
    Get.find<StudentController>().addStudent(student);
  }
}
