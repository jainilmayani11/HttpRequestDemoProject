import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/pictures.dart';
import '../model/user.dart';
import '../model/userName.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Users> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Center(
            child: Text(
          "Rest APi Call",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user.email;

            return ListTile(
              trailing: Text(user.gender),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(user.picture.thumbnail)),
              title: Text(user.name.first),
              subtitle: Text(user.email),
            );
          }),
    );
  }

  Future<void> fetchUsers() async {
    print("Fetch Users");
    const url = 'https://randomuser.me/api/?results=15';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;

    final transformed = results.map((e) {
      final picture = Pictures(
        large: e['picture']['large'],
        medium: e['picture']['medium'],
        thumbnail: e['picture']['thumbnail'],
      );

      final name = UserName(
          title: e['name']['title'],
          first: e['name']['first'],
          last: e['name']['last']);

      return Users(
        cell: e['cell'],
        email: e['email'],
        gender: e['gender'],
        nat: e['nat'],
        phone: e['phone'],
        name: name,
        picture: picture,
      );
    }).toList();

    setState(() {
      users = transformed;
    });

    print("Fetch Users Completed");
  }
}
