// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, avoid_print, unnecessary_null_comparison, use_build_context_synchronously

// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();

  final storage = FirebaseStorage.instance;
  PlatformFile? _selectedFile; // Holds the selected file
  String itemImageUrl = '';

  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('items');

  //----------------------------------------------- Function to handle file selection
  void _handleFileSelection(PlatformFile file) {
    setState(() {
      _selectedFile = file;
    });
  }

  //----------------------------------------- Function to upload the selected file
  Future<void> _choseAndUploadFile() async {
    //-----------------------------------------first chose a file
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Allows picking any file type
    );
    if (result != null) {
      _handleFileSelection(result.files.first);
    } else {
      print('No file selected.');
    }
//------------------------------------upload file to firebase storage
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('please upload an image bro'),
        ),
      );
      //show in debug
      print('No file selected.');

      return;
    }

    try {
      final storageRef = storage.ref().child('images/${_selectedFile!.name}');
      final uploadTask = storageRef.putBlob(_selectedFile!.bytes!);
      await uploadTask.whenComplete(() async {
        // Get the download URL
        itemImageUrl = await storageRef.getDownloadURL();
        print('File uploaded successfully! Download URL: $itemImageUrl');
      });
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  //---------------------------------------------- Function to add item
  Future<void> _addItem() async {
    String itemName = _controllerName.text.trim();
    String itemQuantity = _controllerQuantity.text.trim();
    final existingItems = await itemsCollection
        .where('name', isEqualTo: itemName)
        .where('quantity', isEqualTo: itemQuantity)
        .get();

    if (itemName.isEmpty || itemQuantity.isEmpty || itemImageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Field are empty. fill info or nothing will be created'),
        ),
      );
      print('Field are empty. fill info or nothing will be created');
      return;
    }

    // verifies the data does not exist in the database before sending to database
    try {
      if (existingItems.docs.isEmpty) {
        await itemsCollection.add({
          'name': itemName,
          'quantity': itemQuantity,
          'imageUrl': itemImageUrl,
          // Add other fields as needed
        });
        print('Item added to Firestore collection "items"');
        // clear the fields after adding
        _controllerName.clear();
        _controllerQuantity.clear();
        setState(() {
          _selectedFile = null;
        });
      } else {
        print('Items already exists');
      }
    } catch (e) {
      print('Error adding item: $e');
    }
  }

//---------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload to Firebase Storage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controllerName,
              decoration: InputDecoration(hintText: 'enter name'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'enter the name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _controllerQuantity,
              decoration: InputDecoration(hintText: 'enter name'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'enter the name';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            if (_selectedFile != null)
              Text('Selected File: ${_selectedFile!.name}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _choseAndUploadFile,
              child: Text('Upload File'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('submit it'),
            ),
          ],
        ),
      ),
    );
  }
}
