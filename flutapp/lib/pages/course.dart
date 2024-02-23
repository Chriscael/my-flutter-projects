// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unnecessary_null_comparison, avoid_print
import 'dart:io'; // For File class
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image selection
import 'package:file_picker/file_picker.dart'; // For PDF selection
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data'; // Import Uint8List

class CourseForm extends StatefulWidget {
  const CourseForm({super.key});

  @override
  _CourseFormState createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  final TextEditingController takesCourseName = TextEditingController();
  final TextEditingController takesCourseDescription = TextEditingController();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final docCourse = FirebaseFirestore.instance;
  String courseName = '';
  String description = '';
  String imageUrl = '';
  String pdfUrl = '';
  File? _selectedImage;
  final List<File> _selectedPDFs = [];

  // Function to handle image selection and upload image
  Future<void> pickImage() async {
    //select image
    final pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final imageRef = _storage.ref().child('images/${pickedFile.name}');
      await imageRef.putData(Uint8List.fromList(imageBytes));
      imageUrl = await imageRef.getDownloadURL();
      print('Image uploaded successfully! Download Url $imageUrl');
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Function to handle PDF selection and upload it
  Future<void> pickAndUploadPDFs() async {
    //select pdfs
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      for (var file in result.files) {
        final pdfBytes = file.bytes!;
        final pdfRef = _storage.ref().child('pdfs/${file.name}');
        await pdfRef.putData(Uint8List.fromList(pdfBytes));
        pdfUrl = await pdfRef.getDownloadURL();
        print('PDF ${file.name} uploaded successfully! Download Url $pdfUrl');
        setState(() {
          _selectedPDFs.add(File(file.name));
        });
      }
    }
  }

  // Function to upload data to Firebase
  Future<void> uploadData() async {
    final String courseName = takesCourseName.text.trim();
    final String description = takesCourseDescription.text.trim();

    if (courseName.isEmpty ||
        description.isEmpty ||
        imageUrl == null ||
        pdfUrl == null) {
      print('Please fill in all fields.');
      return;
    }

    // Check for duplicates (assuming 'courses' is your Firestore collection)
    final QuerySnapshot duplicateCheck = await FirebaseFirestore.instance
        .collection('courses')
        .where('courseName', isEqualTo: courseName)
        .get();

    if (duplicateCheck.docs.isNotEmpty) {
      print('Course with the same name already exists.');
      return;
    }

    // Upload data to Firestore
    try {
      await docCourse.collection('courses').add({
        'courseName': courseName,
        'description': description,
        'courseImage': imageUrl,
        'coursePdfs': _selectedPDFs.map((pdf) => pdfUrl).toList(),
        // Add other fields as needed
      });

      print('Course data uploaded successfully!');
      // Clear the fields
      takesCourseName.clear();
      takesCourseDescription.clear();
      setState(() {
        _selectedPDFs == null;
        _selectedImage == null;
      });
    } catch (e) {
      print('Error uploading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: takesCourseName,
              decoration: InputDecoration(labelText: 'Course Name'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: takesCourseDescription,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            if (_selectedImage != null)
              Container(
                color: Colors.blue[100],
                width: 100,
                height: 100,
                child: Center(
                  child: Image.network(
                    _selectedImage!.path,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Select Course Image'),
            ),
            // if (imageFile != null) Image.network(imageFile!.path),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: pickAndUploadPDFs,
              child: Text('Select PDF Files'),
            ),
            if (_selectedPDFs.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _selectedPDFs.map((pdf) {
                  return Text('Selected PDF: $pdf.');
                }).toList(),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: uploadData,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
