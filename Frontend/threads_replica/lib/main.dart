import 'package:flutter/material.dart';
import 'package:threads_replica/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

// [
//     {
//         "_id": "655ae8af5badd658d0532070",
//         "postedBy": "655ae7065badd658d0532052",
//         "text": "This is Mohamed's third Post",
//         "likes": [],
//         "replies": [],
//         "createdAt": "2023-11-20T05:03:43.643Z",
//         "updatedAt": "2023-11-20T05:03:43.643Z",
//         "__v": 0
//     },
//     {
//         "_id": "655ae8a85badd658d053206c",
//         "postedBy": "655ae7065badd658d0532052",
//         "text": "This is Mohamed's second Post",
//         "likes": [],
//         "replies": [],
//         "createdAt": "2023-11-20T05:03:36.842Z",
//         "updatedAt": "2023-11-20T05:03:36.842Z",
//         "__v": 0
//     },
//     {
//         "_id": "655ae86f5badd658d0532063",
//         "postedBy": "655ae7065badd658d0532052",
//         "text": "This is Mohamed's Post",
//         "likes": [],
//         "replies": [],
//         "createdAt": "2023-11-20T05:02:39.865Z",
//         "updatedAt": "2023-11-20T05:02:39.865Z",
//         "__v": 0
//     }
// ]
