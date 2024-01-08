// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentsgetx/controller/student_controller.dart';
import 'package:studentsgetx/home.dart';

class Studentscreen extends StatelessWidget {
  final String name;
  final String age;
  final int? id;
  final String div;
  final String rollno;

  Studentscreen({
    super.key,
    required this.name,
    required this.age,
    required this.id,
    required this.div,
    required this.rollno,
  });

  late TextEditingController namecontroller = TextEditingController(text: name);
  late TextEditingController agecontroller = TextEditingController(text: age);
  late TextEditingController divcontroller = TextEditingController(text: div);
  late TextEditingController rollnocontroller = TextEditingController(text: rollno);

  final StudentController _studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      children: [
                        Text('Student name:'),
                        TextFormField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Student name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'value empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text('Age:'),
                      TextFormField(
                        controller: agecontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Age',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'value empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  Row(
                    children: [
                      Text('Class:'),
                      TextFormField(
                        controller: divcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Class',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'value empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  Row(
                    children: [
                      Text('Roll no:'),
                      TextFormField(
                        controller: rollnocontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Roll no',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'value empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (ctx) => Homescreen()),
                              (route) => false);
                        },
                        child: Text('OK'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx1) {
                              return AlertDialog(
                                title: const Text('Delete'),
                                content: const Text('Do you want delete this item'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx1).pop();
                                    },
                                    child: const Text('close'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _studentController.deleteStudent(id!);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (ctx) => Homescreen()),
                                          (route) => false);
                                    },
                                    child: const Text('yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('DELETE'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx1) {
                              return AlertDialog(
                                title: const Text('Update'),
                                content: const Text('Do you want update this item'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx1).pop();
                                    },
                                    child: const Text('close'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      String newName = namecontroller.text.trim();
                                      String newAge = agecontroller.text.trim();
                                      String newDiv = divcontroller.text.trim();
                                      String newRollNo = rollnocontroller.text.trim();

                                      _studentController.updateStudent(
                                          newName, newAge, newDiv, newRollNo, id!);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (ctx) => Homescreen()),
                                          (route) => false);
                                    },
                                    child: const Text('yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('UPDATE'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
