import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:usersupervisor/login.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  File? file;
  var options = [
    'User',
    'Supervisor',
  ];
  var _currentItemSelected = "User";
  var role = "User";

  bool passwordConfirmed() {
    if (passwordController.text.trim() == confirmpassController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // // Logo
                  // const Icon(
                  //   Icons.android_rounded,
                  //   size: 100,
                  // ),
                  // const SizedBox(
                  //   height: 75,
                  // ),
                  // Welcome back
                  const Text(
                    'Hello There !',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Register below to continue',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  // Email Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Confirm Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          controller: confirmpassController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Role : ",
                        style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      DropdownButton<String>(
                        isDense: true,
                        isExpanded: false,
                        iconEnabledColor: Colors.grey,
                        focusColor: Colors.grey,
                        items: options.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValueSelected) {
                          setState(() {
                            _currentItemSelected = newValueSelected!;
                            role = newValueSelected;
                          });
                        },
                        value: _currentItemSelected,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Sign up Button and Progress Indicator on pressed calls signUp function
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: () {
                        signUp(emailController.text, passwordController.text,
                            role);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text('Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // Login Now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'I am a member!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: const Text(
                          'Login Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signUp(String email, String password, String role) async {
    const CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, role)});
    }
  }

  postDetailsToFirestore(String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': emailController.text, 'role': role});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
