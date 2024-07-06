import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/autentikasi/signup.dart';
import 'package:project/botnavbar.dart';

class Login extends StatefulWidget {
  final String username;
  final String password;
  const Login({Key? key, this.username = '', this.password = ''});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  String _errorTextUsername = '';
  String _errorTextPassword = '';

  @override
  void initState() {
    super.initState();
    _username.text = widget.username;
    _password.text = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    // Mengetahui tinggi keyboard
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Memastikan halaman tidak bergerak saat keyboard muncul
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/gambar4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'PhotoGal',
                style: GoogleFonts.poppins(
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height - 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white60,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: keyboardHeight),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 50),
                    TextField(
                      controller: _username,
                      decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "Input Your Name Here",
                        errorText: _errorTextUsername.isNotEmpty ? _errorTextUsername : null,
                        labelStyle: TextStyle(color: Color.fromARGB(255, 25, 25, 25)),
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _password,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Input Your Password Here",
                        errorText: _errorTextPassword.isNotEmpty ? _errorTextPassword : null,
                        labelStyle: TextStyle(color: Color.fromARGB(255, 25, 25, 25)),
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
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
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          String user = _username.text;
                          String pass = _password.text;
                          _errorTextUsername = '';
                          _errorTextPassword = '';

                          if (user.isEmpty) {
                            setState(() {
                              _errorTextUsername = 'Username cannot be empty';
                            });
                          }

                          if (pass.isEmpty) {
                            setState(() {
                              _errorTextPassword = 'Password cannot be empty';
                            });
                          }

                          if (user.isNotEmpty && pass.isNotEmpty) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => botNavBar()),
                              (route) => false,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(7, 160, 129, 1),
                          minimumSize: Size(double.infinity, 50),
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 30),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/google.png',
                            width: 20,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 30),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/facebook.png',
                            width: 20,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Continue with Facebook',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    color: Colors.black,
                    height: 20,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        },
                        child: Text(
                          'Sign Up.',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
