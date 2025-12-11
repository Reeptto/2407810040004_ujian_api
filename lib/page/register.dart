import 'dart:convert';

import 'package:ari_2407810040004_ujian_api/page/todo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPage> {
  // 1. Membuat Controller untuk mengambil input user
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool loading = false;
  
  Future<void> cekLogin() async {
    setState(() {
      loading = true;
    });
  }

  Future<void> _registerUser() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String age = _ageController.text;
    String email = _emailController.text;

    if (firstName.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Nama dan email wajib diisi!")),
        );
      return;
    }

    final String url = 'https://dummyjson.com/users';

    try {
      final response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "email": email,
      }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:  Text("Berhasil Mendaftar: $firstName $lastName"),
              backgroundColor: Colors.green,
             ),
          ); 
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TodoPage()),   
          );
        }else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal: ${response.statusCode} - ${response.body}"),
          backgroundColor: Colors.red,
          ));
        }
    } catch (e) {
      if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Terjadi kesalahan: $e"),
        backgroundColor: Colors.red,
      ),
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }
  
  @override
  void dispose() {
    // Selalu dispose controller agar tidak memakan memori
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),
               ElevatedButton(
                onPressed: loading ? null :_registerUser,

                // Memberikan warna ungu pada tombol (sesuai contoh)
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.deepPurple,
                  
                ),
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Masuk", style: TextStyle(
                      color: Colors.black
                    ),),
              ),
            ],
          ),
        )
      ),
    );
  }
}