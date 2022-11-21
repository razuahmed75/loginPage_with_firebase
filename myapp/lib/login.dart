// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/homepage.dart';
import 'package:myapp/signUp.dart';
import 'package:flutter/services.dart';
import 'package:myapp/sharedPreference_auth.dart';

class LoginPage extends StatefulWidget {
  static const String path = "login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  // SaveUserAuth saveUserAuth = SaveUserAuth();

  void _snackBar(text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.red, fontFamily: "Raleway"),
    )));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 255, 255, 255)));
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 28.0,
                  bottom: 14,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 1,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 94, 117, 229),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset(
                "assets/images/undraw.png",
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Column(
            children: [
              Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 52.0,
                      right: 52.0,
                      top: 38,
                    ),
                    child: Column(
                      children: [
                        Material(
                          elevation: 12,
                          shadowColor: Color.fromARGB(255, 43, 99, 61),
                          color: Colors.transparent,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              )),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (e) {
                              if (e!.isEmpty) {
                                return "Field must not be empty!";
                              } else if (!e.contains("@gmail.com")) {
                                return "Enter a valid email!";
                              }
                              return null;
                            },
                            style: TextStyle(
                              letterSpacing: 1.7,
                              color: Color.fromARGB(255, 94, 117, 229),
                              fontFamily: "Raleway",
                            ),
                            cursorColor: Color.fromARGB(255, 54, 235, 244),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(16),
                              filled: true,
                              fillColor: Color.fromARGB(255, 241, 236, 253),

                              prefixIcon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 94, 117, 229),
                              ),
                              suffixIcon: Icon(
                                Icons.mail,
                                color: Color.fromARGB(255, 94, 117, 229),
                              ),
                              hintText: "Email",
                              errorStyle: TextStyle(
                                fontFamily: "Raleway",
                              ),
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 94, 117, 229),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              // suffixIcon: ,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          elevation: 12,
                          color: Colors.transparent,
                          shadowColor: Color.fromARGB(255, 43, 99, 61),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (e) {
                              if (e!.isEmpty) {
                                return "Field must not be empty!";
                              } else if (e.length < 8) {
                                return "Password should be in 8 characters!";
                              }
                              return null;
                            },
                            obscureText: _obscureText,
                            obscuringCharacter: "◉",
                            style: TextStyle(
                              letterSpacing: 1.7,
                              color: Color.fromARGB(255, 94, 117, 229),
                              fontFamily: "Raleway",
                            ),
                            cursorColor: Color.fromARGB(255, 54, 235, 244),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 241, 236, 253),
                              contentPadding: EdgeInsets.all(16),

                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 94, 117, 229),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Color.fromARGB(255, 94, 117, 229),
                                  )),
                              hintText: "Password",
                              errorStyle: TextStyle(
                                fontFamily: "Raleway",
                              ),
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 94, 117, 229),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              // suffixIcon: ,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 30,
                              ),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        fontFamily: "Raleway",
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 144, 141, 141)),
                                  )),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 94, 117, 229),
                            elevation: 12,
                            shadowColor: Color.fromARGB(255, 43, 99, 61),
                            minimumSize: Size(290, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text);
                                if (userCredential.user != null) {
                                  SaveUserAuth.setCredential(
                                      userCredential.user!.uid);

                                  Navigator.of(context)
                                      .pushNamed(HomePage.path);
                                }
                                final route = MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          user: userCredential.user!.uid,
                                        ));
                                Navigator.push(context, route);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  _snackBar('Please enter a valid email!');
                                } else if (e.code == 'wrong-password') {
                                  _snackBar('Please enter a valid password!');
                                }
                              } catch (e) {
                                _snackBar(
                                    "Please enter valid email or password!");
                              }
                            }
                          },
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Raleway",
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an Account?",
                              style: TextStyle(
                                fontFamily: "Raleway",
                                color: Color.fromARGB(255, 144, 141, 141),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, SignUp.path);
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontFamily: "Raleway",
                                    color: Color.fromARGB(255, 94, 117, 229),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              Image.asset(
                "assets/images/bottom.png",
                width: 900,
                height: 143,
                fit: BoxFit.fill,
              ),
            ],
          )
        ],
      ),
    );
  }
}
