import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/gambar4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'PhotoGal',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        textStyle: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
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
                    child: Column(
                      children: [
                        SizedBox(height:50),
                        TextField(
                          controller: _username,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Username",
                            labelStyle: TextStyle(color: Color.fromARGB(255, 25, 25, 25)),
                            hintText: "Input Your Name Here",
                            hintStyle: TextStyle(color: Color.fromARGB(255, 119, 119, 119)),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            errorText: _errorTextUsername.isNotEmpty
                                ? _errorTextUsername
                                : null,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _password,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(color: const Color.fromARGB(255, 25, 25, 25)),
                            hintText: "Input Your Password Here",
                            hintStyle: TextStyle(color: Color.fromARGB(255, 119, 119, 119)),
                            errorText: _errorTextPassword.isNotEmpty
                                ? _errorTextPassword
                                : null,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 40,
                        ),
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
                        SizedBox(height: 40),
                        OutlinedButton(
                          onPressed: () {

                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(double.infinity, 40),
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            side: BorderSide(color: Colors.white),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/google.png',
                                width: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Continue with Google',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight : FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        OutlinedButton(
                          onPressed: () {

                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(double.infinity, 40),
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            side: BorderSide(color: Colors.white),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/facebook.png',
                                width: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Continue with Facebook',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight : FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Column(
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
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Signup(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up.',
                              style: TextStyle(
                                color: Color.fromARGB(255, 254, 255, 255),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}