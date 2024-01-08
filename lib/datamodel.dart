

import 'package:flutter/foundation.dart';

class StudentModel {
  ValueNotifier<int?> id;
  ValueNotifier<String> name;
  ValueNotifier<String> age;
  ValueNotifier<String> div;
  ValueNotifier<String> rollno;
  ValueNotifier<String> imagepath;

  StudentModel({
    required String name,
    required String age,
    required String div,
    required String rollno,
    required String imagepath,
    int? id,
  })  : id = ValueNotifier<int?>(id),
        name = ValueNotifier<String>(name),
        age = ValueNotifier<String>(age),
        div = ValueNotifier<String>(div),
        rollno = ValueNotifier<String>(rollno),
        imagepath = ValueNotifier<String>(imagepath);

  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final div = map['div'] as String;
    final rollno = map['rollno'] as String;
    final imagepath = map['imagepath'] as String;
    return StudentModel(id: id, name: name, age: age, div: div, rollno: rollno, imagepath: imagepath);
  }
}