import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/new_user_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Networking App',
      theme: ThemeData(primaryColor: Colors.blue),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List users = [];
  void getUsers() async {
    String url =
        "https://crudcrud.com/api/f49b3774d8a844dab0b6b2481d08a241/users";
    final response =
        await http.get(Uri.parse(url)); // await is used to wait the
    //entire system untill response will not come
    final body = jsonDecode(response.body);
    users = body;
    //to refresh
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Networking app"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            users.isEmpty
                ? const Text("No users found")
                : Column(
                    children: users
                        .map((user) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                                "Name: ${user["name"]} Age : ${user["age"]}")))
                        .toList()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      getUsers();
                    },
                    child: const Text("Get users")),
                const SizedBox(width: 10.0),
                OutlinedButton(
                    onPressed: ()
                        //code used to create new screen and must import this in main.dart
                        {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewUserScreen(),
                        ),
                      );
                    },
                    child: const Text("New user")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
