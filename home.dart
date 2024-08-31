import 'package:flutter/material.dart';
import 'package:flutter_application_8/models/users.dart';
import '../models/config.dart';
import '../models/user_data.dart';
import 'side_menu.dart';
import 'add_edit_user.dart';

class Home extends StatefulWidget {
  static const routeName = "/";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Users> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      drawer: const SideMenu(),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(user.fullname!),
              subtitle: Text(user.email!),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final updatedUser = await Navigator.push<Users>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditUser(user: user),
                    ),
                  );
                  if (updatedUser != null) {
                    setState(() => users[index] = updatedUser);
                  }
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserInfo(user: user)),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newUser = await Navigator.push<Users>(
            context,
            MaterialPageRoute(builder: (context) => const AddEditUser()),
          );
          if (newUser != null) {
            setState(() => users.add(newUser));
          }
        },
        child: const Icon(Icons.person_add, color: Colors.white),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
