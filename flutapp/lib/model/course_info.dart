// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String id;
  String name;
  String image;
  String description;
  String pdfs;

  Course({
    this.id = '',
    required this.name,
    required this.image,
    required this.description,
    required this.pdfs,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'courseName': name,
        'description': image,
        'courseImage': description,
        'coursePdfs': pdfs,
      };

  static Course fromJson(Map<String, dynamic> json) => Course(
        id: json['id'],
        image: json['courseImage'],
        name: json['courseName'],
        description: json['description'],
        pdfs: json['coursePdfs'],
      );
}
