import 'package:flutter/material.dart';
import 'package:learning_database_in_flutter/db_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbhelper = DatabaseHelper.instence;
  void insertdata() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: "Ali",
      DatabaseHelper.columnage: 20
    };
    final id = await dbhelper.insert(row);
    print(id);
  }

  void queryAll() async {
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      print(row);
    });
  }

  void querySpecific() async {
    var allResult = await dbhelper.queryspecific(18);
    print(allResult);
  }

  void delete() async {
    var deleleId = await dbhelper.deleteData(1);
    print(deleleId);
  }

  void update() async {
    var row = await dbhelper.update(2);
    print(row);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CURD'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: insertdata,
              child: const Text('INSERT'),
            ),
            ElevatedButton(
              onPressed: queryAll,
              child: const Text('QUERY'),
            ),
            ElevatedButton(
              onPressed: querySpecific,
              child: const Text('QUERY SPECIFIC'),
            ),
            ElevatedButton(
              onPressed: update,
              child: const Text('UPDATE'),
            ),
            ElevatedButton(
              onPressed: delete,
              child: const Text('DELETE'),
            ),
          ],
        ),
      ),
    );
  }
}
