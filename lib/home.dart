import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentsgetx/SearchPage.dart';
import 'package:studentsgetx/controller/student_controller.dart';
import 'package:studentsgetx/create.dart';
import 'package:studentsgetx/datamodel.dart';
import 'package:studentsgetx/login.dart';
import 'package:studentsgetx/student.dart';

enum LayoutType {
  ListView,
  GridView,
}

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final StudentController _studentController = Get.find<StudentController>();
  final LayoutTypeController _layoutTypeController = Get.put(LayoutTypeController());

  Widget _buildBody() {
    return Obx(() {
      final studentList = _studentController.studentList;
      if (studentList.isEmpty) {
        return const Center(
          child: Text('No items found'),
        );
      }

      if (_layoutTypeController.layoutType == LayoutType.ListView) {
        return ListView.separated(
          itemCount: studentList.length,
          separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey),
          itemBuilder: (context, index) {
            final data = studentList[index];
            return ListTile(
              title: Text(data.name.value),
              leading: _buildImageWidget(data),
              onTap: () {
                Get.to(
                  () => Studentscreen(
                    name: data.name.value,
                    age: data.age.value,
                    id: data.id.value!,
                    div: data.div.value,
                    rollno: data.rollno.value,
                  ),
                );
              },
            );
          },
        );
      } else {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: studentList.length,
          itemBuilder: (context, index) {
            final data = studentList[index];
            return GestureDetector(
              onTap: () {
                Get.to(
                  () => Studentscreen(
                    name: data.name.value,
                    age: data.age.value,
                    id: data.id.value!,
                    div: data.div.value,
                    rollno: data.rollno.value,
                  ),
                );
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildImageWidget(data),
                    const SizedBox(height: 8),
                    Text(data.name.value),
                  ],
                ),
                elevation: 4,
                margin: const EdgeInsets.all(8),
              ),
            );
          },
        );
      }
    });
  }

  Widget _buildImageWidget(StudentModel student, {double width = 60, double height = 60}) {
    if (student.imagepath.value.isNotEmpty) {
      return Image.file(
        File(student.imagepath.value),
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/images/student.jpg',
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
        actions: [
          IconButton(
            onPressed: _navigateToSearchPage,
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<LayoutType>(
            onSelected: (layout) {
              _layoutTypeController.setLayoutType(layout);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<LayoutType>>[
              const PopupMenuItem<LayoutType>(
                value: LayoutType.ListView,
                child: const Text('List View'),
              ),
              const PopupMenuItem<LayoutType>(
                value: LayoutType.GridView,
                child: const Text('Grid View'),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              _showLogoutDialog();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
        leading: Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.all(4),
          child: const CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/images/rose.jpg'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => Createscreen());
        },
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  void _navigateToSearchPage() async {
    final searchResults = await Get.to(() => SearchPage());

    if (searchResults != null && searchResults is List<StudentModel>) {
      _studentController.studentList.value = searchResults;
    }
  }

  void _showLogoutDialog() {
    Get.defaultDialog(
      title: 'Logout',
      content: const Text('Are you sure you want to logout?'),
      textConfirm: 'Yes',
      confirm: ElevatedButton(
        onPressed: () {
          _signout();
          Get.back();
        },
        child: const Text('Yes'),
      ),
      textCancel: 'No',
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('No'),
      ),
    );
  }

  void _signout() async {
    final _sharedprefs = await SharedPreferences.getInstance();
    await _sharedprefs.clear();

    Get.offAll(() => Loginscreen());
  }
}

class LayoutTypeController extends GetxController {
  Rx<LayoutType> _layoutType = LayoutType.ListView.obs;

  LayoutType get layoutType => _layoutType.value;

  void setLayoutType(LayoutType layoutType) {
    _layoutType.value = layoutType;
  }
}
