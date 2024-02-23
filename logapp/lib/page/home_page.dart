// ignore_for_file: prefer_const_constructors, avoid_print, unused_field, unused_local_variable

//import 'package:firebase_auth/firebase_auth.dart';
//import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:core';

FirebaseStorage storage = FirebaseStorage.instance;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> key = GlobalKey();
  //
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();

  String _selectedFilePath = '';
  String _uploadStatus = '';

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('my_courses');

  Future<void> _selectFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (pickedFile != null) {
      final bytes = pickedFile.files.single.bytes;
      final fileName = pickedFile.files.single.name;

      if (fileName.endsWith('.jpg') ||
          fileName.endsWith('.jpeg') ||
          fileName.endsWith('.png')) {
        // Proceed with upload
      } else {
        setState(() {
          _uploadStatus =
              "Selected file is not an image (allowed: jpg, jpeg, png).";
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    // if (_selectedFilePath.isEmpty) {
    //   setState(() {
    //     _uploadStatus = 'Please select a file first.';
    //   });
    //   return;
    // }

    if (_selectedFilePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('please upload an image bro'),
        ),
      );

      return;
    }

    try {
      final fileName = _selectedFilePath.split('/').last;
      final ref = storage.ref().child('storage/$fileName');

      final bytes = await FilePicker.platform
          .pickFiles(allowMultiple: false)
          .then((result) => result?.files.single.bytes);

      // Check bytes are not null before upload
      if (bytes != null) {
        final task = ref.putData(bytes);

        final snapshot = await task.whenComplete(() => null);

        // Get file metadata after upload
        final metadata = await snapshot.ref.getMetadata();

        if (metadata.contentType?.startsWith('image/') ?? false) {
          final url = await snapshot.ref.getDownloadURL();
          setState(() {
            _uploadStatus = 'Image uploaded successfully: $url';
            _selectedFilePath = ''; // Clear selected file after upload
          });
        } else {
          setState(() {
            _uploadStatus = "Selected file is not an image.";
          });
          // Delete the incorrect file in storage
          await snapshot.ref.delete();
        }
      } else {
        setState(() {
          _uploadStatus = "Error: Could not access file data.";
        });
      }
    } on FirebaseException catch (e) {
      setState(() {
        _uploadStatus = 'Error uploading file: ${e.code}';
      });
      print(e.code);
      print(e.message);
    } on Exception catch (e) {
      setState(() {
        _uploadStatus = 'Error uploading file:';
        //${e.message}
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    //String imageUrl = '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.email!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: <Widget>[
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(Icons.arrow_back, size: 32),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(),
              TextFormField(),
              Text(_uploadStatus),
              Text(_selectedFilePath),
              // Expanded(
              //   child: Container(
              //     color: Colors.blue[100],
              //     child: Center(
              //       child: Image.network(_selectedFilePath,
              //         width: double.infinity,
              //         fit: BoxFit.cover,
              //       ),
              //       //TO isplay any aother file
              //       // Text(pickedFile!.name),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: _selectFile,
                child: Text('Select File'),
              ),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Upload File'),
              ),
              // SizedBox(
              //   height: 32,
              // ),
              // ElevatedButton(
              //   onPressed: () async {
              //     if (imageUrl.isEmpty) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(
              //           content: Text('please upload an image bro'),
              //         ),
              //       );

              //       return;
              //     }

              //     if (key.currentState!.validate()) {
              //       String itemName = _controllerName.text;
              //       String itemQuantity = _controllerQuantity.text;

              //       //create a map of data
              //       Map<String, String> dataToSend = {
              //         'name': itemName,
              //         'quantity': itemQuantity,
              //         'image': imageUrl,
              //       };

              //       _reference.add(dataToSend);
              //     }
              //   },
              //   child: Text('submit'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// // step 1 pick image
// ImagePicker imagePicker = ImagePicker();

// XFile? file = await imagePicker.pickImage(
//     source: ImageSource.gallery);
// print('${file?.path}');

// //step 2 upload to firebase storage
// if (file == null) return;

// String uniqueFileName =
//     DateTime.now().millisecondsSinceEpoch.toString();

//     //get reference to storage root
// Reference referenceRoot = FirebaseStorage.instance.ref();
// Reference referenceDirImages =
//     referenceRoot.child('images');

//     //create reference for image to be stored
// Reference referenceImageToUpload =
//     referenceDirImages.child(uniqueFileName);

//     //handle errors/success
// try {
//   //store the file
//   await referenceImageToUpload.putFile(File(file!.path));

//   imageUrl = await referenceImageToUpload.getDownloadURL();
// } catch (error) {
//   //// error code
// }
