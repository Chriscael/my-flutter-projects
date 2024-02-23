// ignore_for_file: body_might_complete_normally_nullable, unused_field, prefer_const_constructors, avoid_print, unused_element

import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  late String _name;
  late String _email;
  late String _password;
  late String _url;
  late String _phoneNumber;
  late String _calories;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Name'),
      maxLength: 50,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Name is required';
        }
        return null;
      },
      onSaved: (value) {
        _name = value!;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'email'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'email is required';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }
        return null;
      },
      onSaved: (value) {
        _email = value!;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'password'),
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'password is required';
        }
        return null;
      },
      onSaved: (value) {
        _password = value!;
      },
    );
  }

  Widget _buildUrl() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'url'),
      keyboardType: TextInputType.url,
      validator: (value) {
        if (value!.isEmpty) {
          return 'url is required';
        }
        return null;
      },
      onSaved: (value) {
        _url = value!;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'phoneNumber'),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return 'phoneNumber is required';
        }
        return null;
      },
      onSaved: (value) {
        _phoneNumber = value!;
      },
    );
  }

  Widget _buildCalories() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Calories'),
      keyboardType: TextInputType.number,
      validator: (value) {
        int? calories = int.tryParse(value!);

        if (calories == null || calories <= 0) {
          return 'calories must be greater than 0';
        }
        return null;
      },
      onSaved: (value) {
        _calories = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Demo"),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              _buildEmail(),
              _buildPassword(),
              _buildUrl(),
              _buildPhoneNumber(),
              _buildCalories(),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () => {
                  if (!_formkey.currentState!.validate()) {},
                  _formkey.currentState!.save(),
                  print(_name),
                  print(_email),
                  print(_phoneNumber),
                  print(_url),
                  print(_password),
                  print(_calories),
                },
                child: const Text(
                  'submit',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
