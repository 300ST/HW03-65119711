import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/users.dart';
import '../models/config.dart';

class AddEditUser extends StatefulWidget {
  final Users? user;

  const AddEditUser({this.user, Key? key}) : super(key: key);

  @override
  State<AddEditUser> createState() => _AddEditUserState();
}

class _AddEditUserState extends State<AddEditUser> {
  final _formKey = GlobalKey<FormState>();
  late Users _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user ?? Users();
  }

  Widget _buildInputField({
    required String label,
    required String? initialValue,
    required Function(String?) onSave,
    required IconData icon,
  }) {
    return Focus(
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;
          return TextFormField(
            initialValue: initialValue,
            obscureText: label == 'Password',
            decoration: InputDecoration(
              labelText: label,
              labelStyle:
                  TextStyle(color: isFocused ? Colors.blue : Colors.grey),
              prefixIcon:
                  Icon(icon, color: isFocused ? Colors.blue : Colors.grey),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            onSaved: onSave,
          );
        },
      ),
    );
  }

  Widget _buildGenderField() {
    return DropdownButtonFormField<String>(
      value: _user.gender,
      decoration: const InputDecoration(
        labelText: 'Gender',
        prefixIcon: Icon(Icons.person, color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      items: ['None', 'Male', 'Female']
          .map((label) => DropdownMenuItem(
                value: label,
                child: Text(label),
              ))
          .toList(),
      onChanged: (value) => setState(() {
        _user.gender = value;
      }),
    );
  }

  Future<void> _saveUser() async {
    _formKey.currentState?.save();
    Navigator.pop(context, _user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Form', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputField(
                label: 'Full Name',
                initialValue: _user.fullname,
                onSave: (value) => _user.fullname = value,
                icon: Icons.person,
              ),
              _buildInputField(
                label: 'Email',
                initialValue: _user.email,
                onSave: (value) => _user.email = value,
                icon: Icons.email,
              ),
              _buildInputField(
                label: 'Password',
                initialValue: _user.password,
                onSave: (value) => _user.password = value,
                icon: Icons.lock,
              ),
              _buildGenderField(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUser,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child:
                    const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
