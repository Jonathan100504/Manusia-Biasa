import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/autentikasi/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();
  String errorUsername = '';
  String errorPassword = '';
  String errorConfirmPassword = '';

  Future<void> _registerUser(String user, String pass) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user);
    await prefs.setString('password', pass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/gambar1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'PhotoGal',
                style: GoogleFonts.getFont(
                  "Poppins",
                  textStyle: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height - 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white60,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    TextField(
                      controller: username,
                      decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "Input Your Name Here",
                        errorText:
                            errorUsername.isNotEmpty ? errorUsername : null,
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 25, 25, 25),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Input Your Password Here",
                        errorText:
                            errorPassword.isNotEmpty ? errorPassword : null,
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 25, 25, 25),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: confirm,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Confirm Password",
                        errorText: errorConfirmPassword.isNotEmpty
                            ? errorConfirmPassword
                            : null,
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 25, 25, 25),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            String user = username.text;
                            String pass = password.text;
                            String confPass = confirm.text;
                            errorUsername = '';
                            errorPassword = '';
                            errorConfirmPassword = '';

                            if (user.isEmpty ||
                                pass.isEmpty ||
                                confPass.isEmpty) {
                              if (user.isEmpty) {
                                errorUsername = "Username cannot be empty";
                              }
                              if (pass.isEmpty) {
                                errorPassword = "Password cannot be empty";
                              }
                              if (confPass.isEmpty) {
                                errorConfirmPassword =
                                    "Confirm Password cannot be empty";
                              }
                            } else if (pass != confPass) {
                              errorConfirmPassword = "Passwords do not match";
                            } else {
                              _registerUser(user, pass).then((_) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              });
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(7, 160, 129, 1),
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
