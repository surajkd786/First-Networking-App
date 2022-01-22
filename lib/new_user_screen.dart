import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewUserScreen extends StatelessWidget {
  NewUserScreen({Key? key}) : super(key: key);
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  Future<void> addUser() async {
    String name = _nameController.text;
    int age = int.parse(_ageController.text);
    String url =
        "https://crudcrud.com/api/f49b3774d8a844dab0b6b2481d08a241/users";
    var user_data = jsonEncode({"name": name, "age": age});
    final response = await http.post(Uri.parse(url),
        headers: {"Content-type": "application/json; charset=utf-8"},
        body: user_data); // await is used to
    // wait the entire system untill response will not come
    print(response.body);

    // print(name);
    // print(age);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New user"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration:
                    const InputDecoration(hintText: "Enter your Name here"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _ageController,
                decoration:
                    const InputDecoration(hintText: "Enter your gae here"),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton(
                onPressed: () async {
                  await addUser();
                  Navigator.pop(context);
                },
                child: const Text("Add User"),
              ),
            ],
          ),
        ));
  }
}
