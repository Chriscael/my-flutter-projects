// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutapp/pages/course.dart';
import 'package:flutter/material.dart';

//_reference.get() --> returns Futere<QuerySnapshot>
//_reference.snapshot()---> Stream<QuerySnapshot> --- realtime updates
late Stream<QuerySnapshot> _stream;
final _reference = FirebaseFirestore.instance.collection('courses');

class CourseList extends StatefulWidget {
  CourseList({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  //final _reference = FirebaseFirestore.instance.collection('courses');

  //late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //check error
            if (snapshot.hasError) {
              return Center(
                child: Text('some error occured ${snapshot.error}'),
              );
            }
            //check if data arrived
            if (snapshot.hasData) {
              //get the data
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;

              //conveert the documents to maps
              List<Map> courses = documents
                  .map((e) => {
                        'id': e.id,
                        'name': e['courseName'],
                        'description': e['description'],
                      })
                  .toList();

              //Display list
              return ListView.builder(
                itemCount: courses.length,
                itemBuilder: (BuildContext context, int index) {
                  //Get the course at this index
                  Map thisCourse = courses[index];
                  //return the widget for the list of course
                  return ListTile(
                    title: Text('${thisCourse['name']}'),
                    subtitle: Text('${thisCourse['description']}'),
              )
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CourseForm(),
            ),
          );
        },
      ),
    );
  }
}


// itemCount: snapshot.data!.docs.length,
              // itemBuilder: (context, index) => Container(
              //   child: Row(
              //     children: [
              //       Container(
              //         child: Text(
              //           snapshot.data!.docs[index]['courseName'],
              //         ),
              //       ),
              //       Container(
              //         child: Text(
              //           snapshot.data!.docs[index]['description'],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

// body: StreamBuilder<List<Course>>(
//           stream: readCourses(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Text('Something went wrong! ${snapshot.error}');
//             } else if (snapshot.hasData) {
//               final courses = snapshot.data;

//               return ListView(
//                 children: courses!.map(buildCourse).toList(),
//               );
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           }),

//outside the scaffold
// Widget buildCourse(Course course) => ListTile(
//         leading: CircleAvatar(
//           backgroundImage: NetworkImage(course.image),
//         ),
//         title: Text(course.name),
//         subtitle: Text(course.description),
//       );

//   Stream<List<Course>> readCourses() => FirebaseFirestore.instance
//       .collection('courses')
//       .snapshots()
//       .map((snapshot) =>
//           snapshot.docs.map((doc) => Course.fromJson(doc.data())).toList());