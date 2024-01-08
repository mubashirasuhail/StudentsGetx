
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studentsgetx/datamodel.dart';


class StudentController extends GetxController {
  RxList<StudentModel> studentList = <StudentModel>[].obs;
  late Database _db;

  @override
  void onInit() {
    super.onInit();
    initializeDatabase();
    getAllStudents();
  }

  Future<void> initializeDatabase() async {
    _db = await openDatabase('student.db', version: 1, onCreate: (Database db, int version) {
      db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, div TEXT, rollno TEXT, imagepath TEXT)');
    });
  }

  Future<void> addStudent(StudentModel value) async {
    final _id = await _db.rawInsert(
      'INSERT INTO student(name, age, div, rollno, imagepath) VALUES(?,?,?,?,?)',
      [value.name.value, value.age.value, value.div.value, value.rollno.value, value.imagepath.value],
    );
    value.id.value = _id;
    getAllStudents();
  }

  Future<void> getAllStudents() async {
    final values = await _db.rawQuery('SELECT * FROM student');
    studentList.assignAll(values.map((map) => StudentModel.fromMap(map)));
  }

  Future<void> deleteStudent(int id) async {
    await _db.rawDelete('DELETE FROM student WHERE id=?', [id]);
    getAllStudents();
  }

  Future<void> updateStudent(String newname, String newage, String newdiv, String newrollno, int id) async {
    await _db.rawUpdate('''
      UPDATE student 
      SET name=?, age=?, div=?, rollno=? 
      WHERE id=?
    ''', [newname, newage, newdiv, newrollno, id]);
    getAllStudents();
  }

  Future<List<StudentModel>> searchStudents(String searchQuery) async {
    final results = await _db.query(
      'student',
      where: 'name LIKE ?',
      whereArgs: ['%$searchQuery%'],
    );
    return results.map((map) => StudentModel.fromMap(map)).toList();
  }
}