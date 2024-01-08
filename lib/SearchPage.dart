import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentsgetx/controller/student_controller.dart';
import 'package:studentsgetx/datamodel.dart'; // Import your StudentController

class SearchPage extends StatelessWidget {
  final StudentController _studentController = Get.find(); // Get reference to StudentController

  final searchController = TextEditingController();

  void _performSearch() async {
    // Get search query
    String searchQuery = searchController.text;

    // Perform search using StudentController
    List<StudentModel> searchResults = await _studentController.searchStudents(searchQuery);

    // Navigate back and pass search results
    Get.back(result: searchResults);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Students')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: searchController, decoration: InputDecoration(hintText: 'Search')),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _performSearch,
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}